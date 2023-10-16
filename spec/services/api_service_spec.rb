# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApiService do
  let(:error_class) { described_class::ApiServiceCallError }

  describe described_class::ApiServiceCallError do
    describe '#message' do
      it 'has correct default error message' do
        expect(subject.message).to eq 'ERROR: API Service call resulted in an error'
      end
    end
  end

  describe '#host' do
    it 'raises error' do
      expect { subject.url }.to raise_error(AttrExtras::MethodNotImplementedError)
    end
  end

  describe '#method' do
    it 'returns GET' do
      expect(subject.method).to eq :get
    end
  end

  describe '#headers' do
    it 'returns nil' do
      expect(subject.headers).to eq({})
    end
  end

  describe '#body' do
    it 'returns nil' do
      expect(subject.body).to be_nil
    end
  end

  describe '#protocol' do
    it 'returns https' do
      expect(subject.protocol).to eq 'https'
    end
  end

  describe '#port' do
    it 'returns nil' do
      expect(subject.port).to be_nil
    end
  end

  describe '#path' do
    it 'returns /' do
      expect(subject.path).to be_nil
    end
  end

  describe '#query' do
    it 'returns empty hash' do
      expect(subject.query).to eq({})
    end
  end

  shared_context 'with example request data' do
    let(:port) { nil }

    before do
      expect(subject).to receive(:protocol)
        .once
        .with(no_args)
        .and_return('http')
      def subject.host; end
      expect(subject).to receive(:host)
        .once
        .with(no_args)
        .and_return('example.com')
      expect(subject).to receive(:port)
        .once
        .with(no_args)
        .and_return(port)
      expect(subject).to receive(:path)
        .once
        .with(no_args)
        .and_return('/some/path')
      expect(subject).to receive(:query)
        .once
        .with(no_args)
        .and_return({ key: 'value' })
    end
  end

  describe '#url' do
    include_context 'with example request data'

    context 'without port' do
      it 'returns correct url' do
        expect(subject.url).to eq 'http://example.com/some/path?key=value'
      end
    end

    context 'with port' do
      let(:port) { 123 }

      it 'returns correct url' do
        expect(subject.url).to eq 'http://example.com:123/some/path?key=value'
      end
    end
  end

  describe '#call' do
    include_context 'with example request data'

    let(:query) { { key: 'value' } }
    let(:response_body_hash) { { returned_key: 'returned_value' } }
    let(:response_body) { response_body_hash.to_json }
    let(:status) { 200 }

    before do
      stub_request(:get, 'http://example.com/some/path')
        .with(query:)
        .to_return(body: response_body, status:)
    end

    context 'when returned successfully' do
      it 'calls external API' do
        subject.call
        expect(a_request(:get, 'http://example.com/some/path').with(query:))
          .to have_been_made.once
      end

      it 'returns correct JSON' do
        expect(subject.call).to match(response_body_hash)
      end
    end

    context 'when status code unsuccessful' do
      let(:status) { 500 }

      it 'raises ApiServiceCallError' do
        expect { subject.call }.to raise_error error_class
      end
    end

    context 'when returned body is blank' do
      let(:response_body) { '' }

      it 'raises ApiServiceCallError' do
        expect { subject.call }.to raise_error error_class
      end
    end

    context 'when returned JSON is blank' do
      let(:response_body_hash) { {} }

      it 'raises ApiServiceCallError' do
        expect { subject.call }.to raise_error error_class
      end
    end
  end
end

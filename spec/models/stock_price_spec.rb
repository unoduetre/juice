# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StockPrice do
  describe 'columns' do
    it { is_expected.to have_db_column(:stock_symbol_id).of_type(:integer).with_options(null: false) }
    it { is_expected.to have_db_column(:timestamp).of_type(:datetime).with_options(null: false) }
    it { is_expected.to have_db_column(:open).of_type(:decimal).with_options(precision: 15, scale: 4, null: false) }
    it { is_expected.to have_db_column(:high).of_type(:decimal).with_options(precision: 15, scale: 4, null: false) }
    it { is_expected.to have_db_column(:low).of_type(:decimal).with_options(precision: 15, scale: 4, null: false) }
    it { is_expected.to have_db_column(:close).of_type(:decimal).with_options(precision: 15, scale: 4, null: false) }
    it { is_expected.to have_db_column(:volume).of_type(:integer).with_options(null: false) }
  end

  describe 'indexes' do
    it { is_expected.to have_db_index(%i[stock_symbol_id timestamp]).unique }
    it { is_expected.to have_db_index(:stock_symbol_id) }
    it { is_expected.to have_db_index(:timestamp) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:stock_symbol).inverse_of(:stock_prices) }
  end

  describe 'validations' do
    subject { create(:stock_price) }

    it { is_expected.to validate_presence_of(:timestamp) }
    it { is_expected.to validate_presence_of(:open) }
    it { is_expected.to validate_presence_of(:high) }
    it { is_expected.to validate_presence_of(:low) }
    it { is_expected.to validate_presence_of(:close) }
    it { is_expected.to validate_presence_of(:volume) }
    it { is_expected.to validate_uniqueness_of(:timestamp).scoped_to(:stock_symbol_id) }
  end
end

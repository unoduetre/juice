# frozen_string_literal: true

# Application controller
class ApplicationController < ActionController::Base
  protected

  def render_json_success
    render json: { status: 'success' }, status: :ok
  end

  def render_json_error(message)
    render json: { status: 'error', message: }, status: :internal_server_error
  end
end

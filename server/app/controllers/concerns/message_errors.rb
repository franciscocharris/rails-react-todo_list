# frozen_string_literal: true

module MessageErrors
  extend ActiveSupport::Concern

  private

  def invalid_header
    render json: { errors: 'authentication header has invalid format' }, status: 403
  end

  def not_header
    render json: { errors: 'authentication header wasn`t sent' }, status: 403
  end

  def w_credentials
    render json: { errors: 'wrong credentials' }, status: 401
  end

  def error_handler(err)
    render json: { errors: err.message }, status: 401
  end

  def no_valid(err)
    render json: { errors: err.record.errors.full_messages }, status: 422
  end

  def b_request(err)
    render json: { errors: err.message }, status: 400
  end
end

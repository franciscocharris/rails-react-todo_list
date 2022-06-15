# frozen_string_literal: true

class ApplicationController < ActionController::API
  #
  class AutorizationError < StandardError; end
  class HeaderNotSent < AutorizationError; end
  class InvalidHeader < AutorizationError; end
  #

  class AuthenticationError < StandardError; end

  #
  rescue_from HeaderNotSent, with: :not_header
  rescue_from InvalidHeader, with: :invalid_header
  #

  rescue_from AuthenticationError, with: :w_credentials
  rescue_from JWT::DecodeError, with: :error_handler
  rescue_from ActiveRecord::RecordNotFound, with: :error_handler
  rescue_from ActiveRecord::RecordInvalid, with: :no_valid
  before_action :authorize_request, except: %i[signup login]

  def authorize_request
    validate_request_header(request)

    header = request.headers[:Authorization]
    header = header.split(' ').last
    @decoded = JwtServices::Decoder.call(header)
    @current_user = User.find(@decoded[:id])
  end

  private

  def validate_request_header(request)
    raise HeaderNotSent unless request.headers.key?('Authorization')

    raise InvalidHeader unless request.headers[:Authorization].include?('Bearer ')
  end

  #
  def invalid_header
    render json: { errors: 'authentication header has invalid format' }
  end

  def not_header
    render json: { errors: 'authentication header wasn`t sent' }
  end
  #

  def w_credentials
    render json: { errors: 'wrong credentials' }, status: 401
  end

  def error_handler(err)
    render json: { errors: err.message }, status: 401
  end

  def no_valid(err)
    render json: { errors: err.record.errors.full_messages }, status: 422
  end
end

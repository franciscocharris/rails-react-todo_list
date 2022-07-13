# frozen_string_literal: true

class ApplicationController < ActionController::API
  include MessageErrors

  class AutorizationError < StandardError; end
  class HeaderNotSent < StandardError; end
  class InvalidHeader < StandardError; end
  class AuthenticationError < StandardError; end

  rescue_from HeaderNotSent, with: :not_header
  rescue_from InvalidHeader, with: :invalid_header
  rescue_from AuthenticationError, with: :w_credentials
  rescue_from JWT::DecodeError, with: :error_handler
  rescue_from ActiveRecord::RecordNotFound, with: :error_handler
  rescue_from ActiveRecord::RecordInvalid, with: :no_valid
  rescue_from ActiveRecord::RecordNotDestroyed, with: :no_valid
  rescue_from ActionDispatch::Http::Parameters::ParseError, with: :b_request
  before_action :authorize_request, except: %i[signup login]

  def authorize_request
    validate_request_header(request)

    header = request.headers[:Authorization]
    header = header.split.last
    @decoded = JwtServices::Decoder.call(header)
    @current_user = User.find(@decoded[:id])
  end

  private

  def validate_request_header(request)
    raise HeaderNotSent unless request.headers.key?('Authorization')

    raise InvalidHeader unless request.headers[:Authorization].include?('Bearer ')
  end
end

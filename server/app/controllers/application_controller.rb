# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :error_handler
  rescue_from JWT::DecodeError, with: :error_handler
  before_action :authorize_request, except: %i[signup login]

  def authorize_request
    return render json: { errors: 'authentication header wasn`t sent' } unless request.headers.key?('Authorization')

    header = request.headers[:Authorization]
    header = header.split(' ').last
    @decoded = JwtServices::Decoder.call(header)
    @current_user = User.find(@decoded[:id])
  end

  private

  def error_handler(err)
    render json: { errors: err.message }, status: 401
  end
end

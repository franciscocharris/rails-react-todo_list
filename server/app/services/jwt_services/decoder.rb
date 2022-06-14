# frozen_string_literal: true

module JwtServices
  class Decoder < ApplicationService
    def initialize(token)
      @token = token
    end

    def call
      decoded_token = JWT.decode(@token, ENV['SECRET_KEY'], true, { algorithm: 'HS256' })[0]
      HashWithIndifferentAccess.new decoded_token
    end
  end
end

# frozen_string_literal: true

module JwtServices
  class Encoder < ApplicationService
    def initialize(user_id)
      @payload = user_id
    end

    def call
      JWT.encode @payload, ENV.fetch('SECRET_KEY', nil), 'HS256'
    end
  end
end

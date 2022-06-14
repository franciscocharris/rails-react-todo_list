# frozen_string_literal: true

module JwtServices
  class Encoder < ApplicationService
    def initialize(payload)
      @payload = payload
    end

    def call
      JWT.encode @payload, ENV['SECRET_KEY'], 'HS256'
    end
  end
end

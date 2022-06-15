# frozen_string_literal: true

module V1
  class SessionsController < ApplicationController
    def signup
      @user = User.new(user_params)
      @user.save!
      token = JwtServices::Encoder.call(id: @user.id)
      render json: { token: token }, status: 200
    end

    def login
      @user = User.find_by_email(params[:email].downcase.delete(' '))
      raise AuthenticationError unless @user&.authenticate(params[:password])

      token = JwtServices::Encoder.call(id: @user.id)
      render json: { token: token }, status: 200
    end

    private

    def user_params
      params.permit(:first_name, :last_name, :email, :password)
    end
  end
end

# frozen_string_literal: true

module V1
  class SessionsController < ApplicationController
    def signup
      # byebug
      @user = User.new(user_params)
      return render json: { errors: @user.errors.full_messages }, status: 422 unless @user.save

      @user.create_default_cards
      token = JwtServices::Encoder.call(id: @user.id)
      render json: { token: }, status: 200
    end

    def login
      @user = User.find_by_email(params[:email].downcase.delete(' '))
      return render json: { error: 'unauthorized' }, status: 401 unless @user&.authenticate(params[:password])

      token = JwtServices::Encoder.call(id: @user.id)
      render json: { token: }, status: 200
    end

    private

    def user_params
      params.permit(:first_name, :last_name, :email, :password)
    end
  end
end

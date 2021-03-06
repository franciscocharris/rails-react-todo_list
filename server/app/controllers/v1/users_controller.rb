# frozen_string_literal: true

module V1
  class UsersController < ApplicationController
    before_action :find_user, except: %i[create index]

    def index
      @users = User.all
      render json: @users, status: :ok
    end

    def show
      render json: @user, status: :ok
    end

    def create
      @user = User.new(user_params)
      if @user.save
        render json: @user, status: :created
      else
        render json: { errors: @user.errors.full_messages },
               status: :unprocessable_entity
      end
    end

    def update
      unless @user.update(user_params)
        render json: { errors: @user.errors.full_messages },
               status: :unprocessable_entity
      end
    end

    def destroy
      @user.destroy
    end

    private

    def find_user
      @user = User.find!(params[:id])
    end

    def user_params
      params.permit(
        :avatar, :name, :username, :email, :password, :password_confirmation
      )
    end
  end
end

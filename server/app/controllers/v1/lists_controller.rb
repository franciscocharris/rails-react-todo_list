# frozen_string_literal: true

module V1
  class ListsController < ApplicationController
    before_action :find_list, except: %i[create index]

    def index
      @msg = 'there`s no lists to show'
      return render json: { errors: @msg }, status: 204 unless (@lists = @current_user.lists)

      render json: @lists, status: 200
    end

    def create
      @list = @current_user.lists.new(list_params)
      @list.save!
      render json: { id: @list.id }, status: 201
    end

    def update
      @list.update!(list_params)
    end

    def destroy
      @list.destroy!
    end

    private

    def find_list
      @list = List.find(params[:id])
    end

    def list_params
      params.permit(:id, :name, :n_position)
    end
  end
end

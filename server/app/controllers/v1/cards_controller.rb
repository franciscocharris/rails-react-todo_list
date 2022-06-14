# frozen_string_literal: true

module V1
  class CardsController < ApplicationController
    before_action :find_card, except: %i[create index]

    def index
      return render json: { errors: 'there`s no cards to show' }, status: 204 unless (@cards = @current_user.cards.all)

      render json: @cards, status: :ok
    end

    def create
      @card = @current_user.cards.new(card_params)
      @card.save!
      render json: { id: @card.id }, status: 201
    end

    def update
      @card.update!(card_params)
    end

    def destroy
      @card.destroy
    end

    private

    def find_card
      @card = card.find!(params[:id])
    end

    def card_params
      params.permit(:name, :n_position)
    end
  end
end

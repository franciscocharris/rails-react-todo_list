# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::ListsController, type: :request do
  subject { described_class }
  let!(:user) { create(:user, :to_logg) }
  let!(:token_user) { JwtServices::Encoder.call(id: user.id) }

  describe "GET/ index" do
    context "request with token" do
      context "the user has cards" do
        it do
          # byebug
          get '/v1/cards', headers: { 'Authorization': 'hola' }
          expect(response).to have_http_status 200
          expect(json.size).to eq(3)
        end
      end
    end
  end
end

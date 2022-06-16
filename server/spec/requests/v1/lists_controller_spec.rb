# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::ListsController, type: :request do
  subject { described_class }
  let!(:user) { create(:user, :to_logg) }
  let!(:token_user) { JwtServices::Encoder.call(id: user.id) }
  let(:header) { { 'Authorization': "Bearer #{token_user}" } }
  let(:n_params) do
    { name: 'new name',
      # n_position: 1
    }
  end

  describe "GET/ index" do
    context "correct request" do
      context "the user has lists" do
        it do
          get '/v1/lists', headers: header
          expect(response).to have_http_status 200
          expect(json['data'].size).to eq(3)
        end
      end
    end

    context "incorrrect request" do
      context 'request without header' do
        it do
          get '/v1/lists'
          expect(response).to have_http_status 403
          expect(json['errors']).to eq('authentication header wasn`t sent')
        end
      end

      context 'request with incorrect format header' do
        it do
          get '/v1/lists', headers: { 'Authorization': "bearer #{token_user}" }
          expect(response).to have_http_status 403
          expect(json['errors']).to eq('authentication header has invalid format')
        end
      end
    end
  end

  describe 'POST/ create' do
    context 'when the params are correct' do
      it do
        post '/v1/lists', params: attributes_for(:list, n_position: user.lists.count+1, user_id: user.id), headers: header
        expect(response).to have_http_status 201
      end

      it {
        expect do
          post '/v1/lists', params: attributes_for(:list, n_position: user.lists.count+1, user_id: user.id), headers: header
        end.to change(List, :count).by(1)
      }
    end

    context 'when the params are incorrect' do
      it do
        post '/v1/lists', params: attributes_for(:list, :w_list), headers: header
        expect(response).to have_http_status 422
      end

      it {
        expect do
          post '/v1/lists', params: attributes_for(:list, :w_list, user_id: user.id ), headers: header
        end.to change(List, :count).by(0)
      }
    end
  end

  describe 'POST/ update' do
    context 'when the params are correct' do
      it do
        patch "/v1/lists/#{user.lists[0].id}", params: n_params, headers: header
        expect(user.lists[0].name).to eq(n_params[:name])
      end
    end

    context 'when the params are incorrect' do
      it do
        patch "/v1/lists/#{user.lists[0].id}", params: attributes_for(:list, :w_list), headers: header
        expect(response).to have_http_status 422
      end
    end
  end

  describe 'DELETE /destroy' do
    context "when the request has header" do
      it {
        expect do
          delete "/v1/lists/#{user.lists[0].id}", headers: header
        end.to change(List, :count).by(-1)
      }
    end
    context "when the request has no header" do
      it {
        expect do
          delete "/v1/lists/#{user.lists[1].id}"
        end.to change(List, :count).by(0)
      }
    end
  end
end

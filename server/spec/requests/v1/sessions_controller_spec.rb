# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'v1/sessions_controller', type: :request do
  let!(:user_to_login) { create(:user, :to_logg) }
  let(:user) { build(:user) }

  describe 'POST /signup' do

    context 'when the params are correct' do
      before { post '/v1/signup', params: user.attributes.merge({ password: '12345678' }) }
      it { expect(response).to have_http_status 200 }
      it {
        expect do
          post '/v1/signup', params: attributes_for(:user).merge({ password: '12345678' })
        end.to change(User, :count).by(1)
      }
    end

    context 'when the params are incorrect' do
      before { post '/v1/signup', params: build(:user, :w_user).attributes }
      it { expect(response).to have_http_status 422 }
    end
  end

  describe 'POST/ login' do
    context 'when the credentials are correct' do
      before { post '/v1/login', params: { email: 'user@gmail.com', password: '12345678' } }
      it { expect(response).to have_http_status 200 }
      it { expect(json['token']).to be_an_instance_of String }
      it { expect { JwtServices::Encoder.call(json['token']) }.not_to raise_error }
    end
  end
end

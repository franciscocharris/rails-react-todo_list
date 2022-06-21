# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::TasksController, type: :request do
  let!(:user) { create(:user, :to_logg) }
  let!(:token_user) { JwtServices::Encoder.call(id: user.id) }
  let(:header) { { 'Authorization': "Bearer #{token_user}" } }
  let(:correct_task_params) { attributes_for(:task, user_id: user.id, list_id: user.lists[0].id) }
  let!(:tasks) { create_list(:task, 3, user_id: user.id, list_id: user.lists[0].id) }
  let(:n_params) do
    {
      name: 'new name',
      description: 'new description'
    }
  end

  describe 'POST/ create' do
    context 'when the params are correct' do
      it do
        post '/v1/tasks', params: correct_task_params, headers: header
        expect(response).to have_http_status 201
      end

      it {
        expect do
          post '/v1/tasks', params: correct_task_params, headers: header
        end.to change(Task, :count).by(1)
      }
    end

    context 'when the params are incorrect' do
      it do
        post '/v1/tasks', params: attributes_for(:task, :w_task), headers: header
        expect(response).to have_http_status 422
      end

      it {
        expect do
          post '/v1/tasks', params: attributes_for(:task, :w_task), headers: header
        end.to change(Task, :count).by(0)
      }
    end
  end

  describe 'POST/ update' do
    context 'when the params are correct' do
      it do
        patch "/v1/tasks/#{tasks[0].id}", params: n_params, headers: header
        expect(tasks[0].reload.name).to eq(n_params[:name])
      end
    end

    context 'when the params are incorrect' do
      it do
        patch "/v1/tasks/#{user.tasks[0].id}", params: attributes_for(:task, :w_task), headers: header
        expect(response).to have_http_status 422
      end
    end
  end

  describe 'DELETE /destroy' do
    context "when the request has header" do
      it {
        expect do
          delete "/v1/tasks/#{tasks[0].id}", headers: header
        end.to change(Task, :count).by(-1)
      }
    end
    context "when the request has no header" do
      it {
        expect do
          delete "/v1/tasks/#{tasks[0].id}"
        end.to change(Task, :count).by(0)
      }
    end
  end
end

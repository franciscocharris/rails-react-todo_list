# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :v1 do
    post 'signup', to: 'sessions#signup'
    post 'login', to: 'sessions#login'
    resources :lists, except: %i[show] do
      post 'change_position', on: :member
    end
    resources :tasks
  end
  get '/*a', to: 'application#not_found'
end

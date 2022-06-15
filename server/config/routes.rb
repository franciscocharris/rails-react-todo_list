# frozen_string_literal: true

Rails.application.routes.draw do
  # root ''
  namespace :v1 do
    post 'signup', to: 'sessions#signup'
    post 'login', to: 'sessions#login'
    resources :lists
  end
  get '/*a', to: 'application#not_found'
end

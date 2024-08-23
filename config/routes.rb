# frozen_string_literal: true

Rails.application.routes.draw do
  root 'pages#index'

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :users, only: %i[new create]
  resources :short_urls, only: %i[index new create show]

  get '/:id', to: 'short_urls#redirect', as: 'short'
  get '/short_urls/:id/report', to: 'short_urls#show', as: 'short_url_report'
end

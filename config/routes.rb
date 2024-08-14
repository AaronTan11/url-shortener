Rails.application.routes.draw do
  root 'pages#index'

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  # post 'login', to: 'sessions#create'
  # delete 'logout', to: 'sessions#destroy', as: 'logout'

  resources :users, only: %i[new create]
end

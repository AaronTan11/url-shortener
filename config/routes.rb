Rails.application.routes.draw do
  root 'users#new'

  get 'sessions/new'
  get 'sessions/create'
  get 'users/new'
  get 'users/create'
end

Rails.application.routes.draw do
  get 'sessions/new'

  root to: 'root#index'
  get 'root/index'
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'login', to: 'sessions#destroy'
  get 'about', to: 'about#index'

  resources :exercise_logs
  resources :schedules
  resources :weights
  resources :users
end

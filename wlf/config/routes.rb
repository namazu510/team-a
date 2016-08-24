Rails.application.routes.draw do
  root to: 'root#index'
  get 'root/index'
  get 'signup', to: 'users#new'

  resources :exercise_logs
  resources :schedules
  resources :weights
  resources :users
end

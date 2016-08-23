Rails.application.routes.draw do
  get 'root/index'
  root to: 'root#index'

  resources :exercise_logs
  resources :schedules
  resources :weights
  resources :users
end

Rails.application.routes.draw do
<<<<<<< HEAD
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
=======
  get 'root/index'
  root to: 'root#index'

  resources :exercise_logs
  resources :schedules
  resources :weights
  resources :users
>>>>>>> origin/master
end

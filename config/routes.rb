Rails.application.routes.draw do
  root "users#index"

  get 'add/:id' => 'songs#add'
  get 'login' => 'sessions#new', as: 'new_login'
  post 'login' => 'sessions#create', as: 'login'
  get 'logout' => 'sessions#destroy', as: 'logout'
  resources :users
  resources :songs
end

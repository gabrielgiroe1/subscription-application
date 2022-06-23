Rails.application.routes.draw do
  get 'users/info', to: 'users#info'
  post '/users/charge', to: 'users#charge'
  get 'users/cancel_subscription', to: 'users#cancel_subscription'

  devise_for :users
  root to: "home#index"
  resources :publications, only: [:index, :show]
  namespace :admin do
    resources :publications
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

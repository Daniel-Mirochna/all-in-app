Rails.application.routes.draw do
  devise_for :users, path: 'auth', path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', registration: 'account', sign_up: 'register' }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"

  namespace :users do
    resources :uploads, only: [:index, :show, :update, :destroy]
  end

  resources :cryptocurrencies, only: [:index, :show], param: :coin_id
  get "/coins_list", to: "cryptocurrencies#coins_list" 
end

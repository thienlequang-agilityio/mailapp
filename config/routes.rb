Rails.application.routes.draw do
  get 'home/index'
  root 'home#index'
  resources :posts

  devise_for :users, controllers: { registrations: "registrations" }
end

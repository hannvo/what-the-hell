Rails.application.routes.draw do
  devise_for :users
  root to: "searches#new"

  resources :searches, only: :create
  resources :results, only: :show
end

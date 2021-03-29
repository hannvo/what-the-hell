Rails.application.routes.draw do
  root to: "searches#home"

  resources :searches, only: :create
  resources :results, only: :show

  # Sidekiq Web UI, only for admins.
  require "sidekiq/web"

end

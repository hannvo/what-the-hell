Rails.application.routes.draw do
  devise_for :users
  root to: "searches#home"

  resources :searches, only: :create
  resources :results, only: :show

  # Sidekiq Web UI, only for admins.
  require "sidekiq/web"
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
end

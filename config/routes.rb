Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :searches, only: [:new, :create]

  # Sidekiq Web UI, only for admins.
  require "sidekiq/web"
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
end

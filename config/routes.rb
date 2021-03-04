Rails.application.routes.draw do
  devise_for :users
  root to: "searches#home"

  resources :searches, only: :create
  resources :results, only: :show
  get "/search_actors/:movie_id", to: "searches#get_actors"

  # Sidekiq Web UI, only for admins.
  require "sidekiq/web"
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
end

Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :searches, only: [:new, :create]
  get "/search_actors/:movie_id", to: "searches#get_actors"


  # Sidekiq Web UI, only for admins.
  require "sidekiq/web"
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

end

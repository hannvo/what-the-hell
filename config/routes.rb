Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :searches, only: [:new, :create]
  get "/search_actors/:movie_id", to: "searches#get_actors"
end

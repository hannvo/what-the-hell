Rails.application.routes.draw do
  devise_for :users
  root to: "searches#new"

  resources :searches, only: [:create]
  put "/searches/:id", to: "searches#second_search", as: "second_search"

  get "/search/:id", to: "searches#show", as: "search_preresults"
  get "/result/:id", to: "searches#final_results", as: "search_results"

  # resources :results, only: [:show]
end

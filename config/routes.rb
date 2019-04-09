Rails.application.routes.draw do
  namespace :api do
    resources :movies, only: [:index, :show] do
      get "playback", on: :member
      get "rating", on: :member
    end
    resources :series, only: [:index, :show] do
      get "rating", on: :member
    end
    resources :episodes, only: [:show] do
      get "playback", on: :member
    end
    resources :rentals, only: [:index] do
      post '/movies/:id' => :movies, on: :collection
      post '/series/:id' => :series, on: :collection
    end
  end
end
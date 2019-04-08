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
    resources :rents, only: [:index]
    post '/rents/movie/:id', to: 'rentals#create'
    post '/rents/serie/:id', to: 'rentals#create'
  end
end
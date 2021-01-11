Rails.application.routes.draw do
  resources :playlist_songs, only: [:new, :create, :destroy]
  resources :songs, only: [:index, :show]
  resources :artists, only: [:index, :show]
  resources :playlists
  resources :users, except: [:index]
  resources :favorites, only: [:create, :destroy]
  resources :subscriptions, only: [:create, :destroy]

  get '/signup', to: 'users#new', as: 'signup'
  get '/', to: 'sessions#new', as: 'login'
  post '/sessions', to: 'sessions#create', as: 'sessions'
  delete '/sessions', to: 'sessions#destroy' 
  patch '/songs', to: 'songs#index', as: 'sort_songs'
  patch '/artists', to: 'artists#index', as: 'sort_artists'

  get '/about', to: 'sessions#about', as: 'about'
  patch '/playlists', to: 'playlists#index', as: 'sort_playlists'

  resources :songs, only: [:show] do
    resources :playlist_songs, only: [:new, :create]
  end

  resources :playlists, only: [:show] do
    resources :songs, only: [:show] do
      resources :playlist_songs, only: [:create]
    end
  end

end

# frozen_string_literal: true

Rails.application.routes.draw do
  get '/current_user', to: 'current_user#index'

  devise_for :users, path: '', path_names: {
                                 sign_in: 'login',
                                 sign_out: 'logout',
                                 registration: 'signup'
                               },
                     controllers: {
                       sessions: 'users/sessions',
                       registrations: 'users/registrations'
                     }

  resources :playlists do
    member do
      post 'add_song/:song_id', to: 'playlists#add_song', as: 'add_song'
      delete 'remove_song/:song_id', to: 'playlists#remove_song', as: 'remove_song'
    end

    collection do
      get 'public_playlists', to: 'playlists#public_playlists'
    end
  end

  resources :songs

  get 'up' => 'rails/health#show', as: :rails_health_check
end

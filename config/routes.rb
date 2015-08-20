Rails.application.routes.draw do
    resources :users, only: [:create, :new, :show] do
      get "activate", on: :collection
    end
    resource :session, only: [:create, :new, :destroy]

    resources :bands do
      resources :albums, only: :new
    end

    resources :albums, except: [:index, :new] do
      resources :tracks, only: :new
    end

    resources :tracks, except: [:index, :new]
    resources :notes
end

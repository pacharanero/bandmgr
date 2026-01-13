Rails.application.routes.draw do
  resource :session
  resource :registration, only: %i[new create]
  resources :passwords, param: :token

  resources :accounts, only: %i[new create show edit update]
  resources :bands do
    member do
      post :set_default
    end
    resources :band_memberships, only: %i[create update destroy] do
      post :resend_invite, on: :member
    end
  end
  get "bands/:band_id/calendar/private/:token" => "band_calendars#private_feed", as: :private_band_calendar
  get "bands/:band_id/calendar/public/:token" => "band_calendars#public_feed", as: :public_band_calendar
  get "invitations/:token" => "band_membership_invitations#show", as: :band_membership_invitation
  resources :songs do
    collection do
      get :import
      post :import, action: :run_import
    end
  end
  resources :events do
    collection do
      get :calendar
    end
  end
  resources :setlists do
    member do
      post :duplicate
    end
    collection do
      post :import, action: :run_import
    end
    resources :setlist_songs, only: %i[create destroy] do
      patch :reorder, on: :collection
    end
  end
  resources :tasks, only: %i[index]
  get "admin" => "admin#show", as: :admin
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "bands#index"
end

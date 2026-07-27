Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :bands do
        resources :band_memberships, only: %i[index create update destroy]
      end
      resources :api_keys do
        member do
          post :revoke
        end
      end
      resources :songs
      resources :setlists
      resources :events
      resources :tasks
      resources :comments, only: %i[index create]
      resources :attachments, only: %i[index create destroy]
      resources :notifications, only: %i[index update]
    end
  end

  resource :session
  resource :registration, only: %i[new create]
  resources :passwords, param: :token

  resources :accounts, only: %i[new create show edit update]
  resources :bands do
    member do
      post :set_default
      delete :purge_gallery_image
      get :chat, to: "band_chats#show"
    end
    resources :band_memberships, only: %i[create update destroy] do
      post :resend_invite, on: :member
    end
  end
  resources :chat_channels, only: %i[create]
  resources :chat_messages, only: %i[create]
  resources :push_subscriptions, only: %i[create destroy]
  resources :attachments, only: %i[show destroy]
  get "gallery/:signed_id" => "public_gallery_images#show", as: :public_gallery_image
  post "chat_message_reactions/:message_id/toggle" => "chat_message_reactions#toggle", as: :toggle_chat_message_reaction
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
      get :print
      get :export
    end
    collection do
      post :import, action: :run_import
    end
    resources :setlist_songs, only: %i[create destroy] do
      patch :move, on: :member
      patch :reorder, on: :collection
      post :bulk_create, on: :collection
      delete :bulk_destroy, on: :collection
    end
  end
  resources :tasks, only: %i[index create update destroy]
  resources :comments, only: %i[create]
  resources :notifications, only: %i[index]
  get "admin" => "admin#show", as: :admin
  get "style-guide" => "style_guides#show", as: :style_guide
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker.js" => "service_workers#show", as: :service_worker

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "public_sites#show"
end

Rails.application.routes.draw do
  resource :session
  resource :registration, only: %i[new create]
  resources :passwords, param: :token

  resources :accounts, only: %i[new create show]
  resources :bands do
    resources :band_memberships, only: %i[create update destroy]
  end
  resources :songs
  resources :events, only: %i[index]
  resources :setlists, only: %i[index]
  resources :tasks, only: %i[index]
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

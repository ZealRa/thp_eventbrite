Rails.application.routes.draw do
  root 'events#index'
  get 'static_pages/index'
  get 'static_pages/secret'

  devise_for :users

  # Routes for users
  resources :user, only: [:index, :show, :new, :create]

  # Routes for events
  resources :events do
    resources :attendances, only: [:create, :destroy]
  end

  # Custom route for sending welcome emails
  post '/send_welcome_email', to: 'users#send_welcome_email'

  # Custom route for sending participation emails
  post '/send_participation_email', to: 'attendances#send_participation_email'


  get "up" => "rails/health#show", as: :rails_health_check
end

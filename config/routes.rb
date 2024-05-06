Rails.application.routes.draw do
  root 'pages#home'

  # Routes for users
  resources :users, only: [:index, :show, :new, :create]

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

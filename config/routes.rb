Rails.application.routes.draw do
  root 'events#index'
  devise_for :users
  resources :user, only: [:index, :show, :new, :create, :edit]
  resources :events, only: [:index, :show, :new, :create] do
      resources :attendance, only: [:create, :destroy]
    end

  #TO DELETE
  get 'static_pages/index'
  get 'static_pages/secret'


  # Custom route for sending welcome emails
  post '/send_welcome_email', to: 'users#send_welcome_email'

  # Custom route for sending participation emails
  post '/send_participation_email', to: 'attendances#send_participation_email'


  get "up" => "rails/health#show", as: :rails_health_check
end

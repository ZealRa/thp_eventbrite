Rails.application.routes.draw do
  root 'events#index'
  devise_for :users
  resources :user, only: [:index, :show, :new, :create, :edit]
  resources :events, only: [:index, :show, :new, :create, :edit, :my_event] do
      resources :attendance, only: [:index, :show, :new, :create, :destroy]
      member do
        get 'my_event' # Ajout de la route pour l'action my_event
      end
    end

  # scope '/checkout' do
  #   post 'create', to: 'checkout#create', as: 'checkout_create'
  #   get 'success', to: 'checkout#success', as: 'checkout_success'
  #   get 'cancel', to: 'checkout#cancel', as: 'checkout_cancel'
  # end

  # #TO DELETE
  # get 'static_pages/index'
  # get 'static_pages/secret'

  # resources :orders, only: [:new, :create]

  # # Custom route for sending welcome emails
  # post '/send_welcome_email', to: 'users#send_welcome_email'

  # # Custom route for sending participation emails
  # post '/send_participation_email', to: 'attendances#send_participation_email'


  get "up" => "rails/health#show", as: :rails_health_check
end

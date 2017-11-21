Rails.application.routes.draw do
  root to: 'home#index'
  get 'layouts', to: 'home#layouts', as: 'layouts'

  namespace :admins do
    resources :dashboard, only: [:index]
    resources :layouts, only: [:create]

    get 'layout', to: 'dashboard#layout', as: 'layout'
    get 'event_type', to: 'dashboard#event_type', as: 'event_type'
    get 'payment', to: 'dashboard#payment', as: 'payment'
    get 'messages', to: 'dashboard#messages', as: 'messages'

    post 'create_layout', to: 'dashboard#create_layout', as: 'create_layout'
    patch 'update_layout/:id', to: 'dashboard#update_layout', as: 'update_layout'
    put 'update_layout/:id', to: 'dashboard#update_layout'
    get 'layout/:id/edit', to: 'dashboard#edit_layout', as: 'edit_layout'
    delete 'destroy_layout/:id', to: 'dashboard#destroy_layout', as: 'destroy_layout'

    post 'create_event_type', to: 'dashboard#create_event_type', as: 'create_event_type'
    patch 'update_event_type/:id', to: 'dashboard#update_event_type', as: 'update_event_type'
    put 'update_event_type/:id', to: 'dashboard#update_event_type'
    delete 'destroy_event_type/:id', to: 'dashboard#destroy_event_type', as: 'destroy_event_type'

    post 'reply_messages', to: 'dashboard#reply_messages', as: 'reply_messages'
    post 'new_email', to: 'dashboard#new_email', as: 'new_email'
  end

  devise_for :admins, path: 'admins', controllers: {
    sessions: 'admins/sessions',
    passwords: 'admins/passwords',
    registrations: 'admins/registrations'
  }

  namespace :users do
    resources :dashboard, only: [:index]
    resources :events, only: [:new, :create, :edit, :update, :show]
    resources :cost_managements, only: [:create]
    resources :paypal
    resources :baokim

    devise_scope :user do
      get '/password/send_instructions' => 'passwords#send_instructions_successfull', as: 'send_instructions_successfull'
    end
  end

  devise_for :users, path: 'users', controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    unlocks: 'users/unlocks',
    omniauth_callbacks: "users/omniauth_callbacks",
    root: "home#index"
  }

  patch 'update_information/:id', to: 'users#update_information', as: 'update_information'
  put 'update_information/:id', to: 'users#update_information'

  post 'new_message', to: 'home#new_message', as: 'new_message'

  patch 'upload_avatar/:id', to: 'users#upload_avatar', as: 'upload_avatar'
  put 'upload_avatar/:id', to: 'users#upload_avatar'

  post 'get_district_ajax', to: 'users#get_district_ajax', as: 'get_district_ajax'
  post 'get_commune_ajax', to: 'users#get_commune_ajax', as: 'get_commune_ajax'
  post 'check_username_ajax', to: 'users#check_username_ajax', as: 'check_username_ajax'

  get ':username', to: 'users#show', as: :user

  post "/hook" => "users/paypal#hook"
  post "/baokim" => "users/baokim#create"
end

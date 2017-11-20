Rails.application.routes.draw do
  root to: 'home#index'

  namespace :admins do
    resources :dashboard, only: [:index]
    resources :layouts, only: [:create]
  end

  devise_for :admins, path: 'admins', controllers: {
    sessions: 'admins/sessions',
    passwords: 'admins/passwords',
    registrations: 'admins/registrations'
  }

  namespace :users do
    resources :dashboard, only: [:index]
    resources :events, only: [:new, :create, :edit, :update, :show]
    resources :layouts, only: [:index]
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

  get "/hook" => "users/paypal#hook"
  get "/baokim" => "users/baokim#create"
  post '/user/dashboard', to: 'users/dashboard#index'
end

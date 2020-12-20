Rails.application.routes.draw do
  root to: 'pages#index'
  get 'about', to: 'pages#about'
  get 'careers', to: 'pages#careers'
  get 'add', to: 'pages#add'
  get 'community', to: 'pages#community'
  get 'pricing', to: 'pages#pricing'
  get 'my_challenges', to: 'challenges#my_challenges'
  get 'office', to: 'pages#office'

  devise_for :users, controllers: {
    registrations: "users/registrations", sessions: "users/sessions"
  } do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :users, path: "profiles", module: "users" do
    resources :followers, only: [:create, :destroy]
  end

  resources :challenges do
    get 'join', to: 'challenges#join'
    get 'leave', to: 'challenges#leave'
    get 'add_friend', to: 'challenges#add_friend'
  end

  resources :challenges, module: "challenges" do
    resources :wins
  end
end

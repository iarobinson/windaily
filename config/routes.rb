Rails.application.routes.draw do
  root to: "pages#index"

  devise_for :users do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  resources :users

  resources :challenges do
    get 'join', to: 'challenges#join'
    get 'leave', to: 'challenges#leave'
    get 'add_friend', to: 'challenges#add_friend'
  end

  resources :challenges, module: "challenges" do
    resources :wins
  end

  get 'my_challenges', to: 'challenges#my_challenges'
end

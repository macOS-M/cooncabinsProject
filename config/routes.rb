Rails.application.routes.draw do
  namespace :admin do
    get 'dashboard', to: 'dashboard#index'
    get 'dashboard/analytics', to: 'dashboard#analytics'
  end
  
  resources :cabins do
    post 'create_review', on: :member
    resources :reviews, only: [:create, :destroy] # Add :destroy to allow review deletion
  end
  
  resources :cabins do
    resources :bookings, only: [:create]
  end
  
  devise_for :users
  get 'home/index'
  get 'home/cabins'

  
  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  

end

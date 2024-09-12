Rails.application.routes.draw do
  namespace :admin do
    get 'dashboard', to: 'dashboard#index'
    get 'dashboard/analytics', to: 'dashboard#analytics'
    get 'dashboard/users', to: 'dashboard#users'
    get 'dashboard/calendar', to: 'dashboard#calendar'
    resources :users, only: [:index, :new, :create, :edit, :update, :destroy]
  end


  resources :bookings, only: [:create, :update, :destroy, :index, :show] do
    post 'confirm_payment', on: :member
    collection do
      get 'calendar_events'
      get 'calendar' 
      get 'user_bookings'
    end
  end
  
  
 
  resources :cabins do
    post 'create_review', on: :member
    resources :reviews, only: [:create, :destroy]
    resources :bookings, only: [:create] # Use nested bookings only for create here
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

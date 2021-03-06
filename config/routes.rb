Rails.application.routes.draw do

  get 'interested/index'

  root 'home#index'
  
  get '/' => 'home#index'

  get 'interested' => 'interested#index'

  devise_for :users, controllers: {registrations: "registrations"}

  resources :events

  resources :pictures, only [:create :new :update :delete]

  resources :charges
  resources :home, only: [:index]

  resources :campus, only: [:index]

  resources :admission, only: [:index]

  resources :schools, only: [:index]

  resources :about, only: [:index]

  resources :contact, only: [:index]

  resources :academic, only: [:index]

  resources :conversations, only: [:create] do
    member do
      post :close
    end
    resources :messages, only: [:create]

  end
end
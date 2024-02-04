Rails.application.routes.draw do
  resources :households, only: [:index, :new, :show, :create, :edit] do
    resources :people, only: [:new, :create]
  end
  resources :people, only: [:index, :show, :edit, :update, :destroy]
  resources :camps, only: [:index, :show] do
    post 'registrations', to: 'registrations#create', as: 'new_registrations'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "people#index"
end

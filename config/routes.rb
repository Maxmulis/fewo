Rails.application.routes.draw do
  resources :households, only: %i[index new show create edit update] do
    resources :people, only: %i[new create]
  end
  resources :people, only: %i[index show edit update destroy]
  resources :camps, only: %i[index show] do
    resources :registrations, only: %i[create new edit index show]
  end
  devise_for :users
  patch 'users/invite/:id', to: 'users#invite', as: :invite_user
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'people#index'
end

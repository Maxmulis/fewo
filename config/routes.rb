Rails.application.routes.draw do
  get 'dashboard', to: 'dashboard#index', as: :dashboard_index

  resources :households, only: %i[index new show create edit update] do
    resources :people, only: %i[new create]
  end
  resources :people, only: %i[index show edit update destroy]
  resources :camps, only: %i[index show new create] do
    resources :registrations, only: %i[create new edit index show]
    resources :camp_team_members, only: %i[create destroy]
  end
  devise_for :users
  patch 'users/invite/:id', to: 'users#invite', as: :invite_user

  root 'dashboard#index'
end

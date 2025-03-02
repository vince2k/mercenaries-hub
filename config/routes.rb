Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :bookings, only: [:index] do
    resources :reviews, only: [:new, :create]
  end

  resources :mercenaries, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    collection do
      get :my_mercenaries
    end
    resources :bookings, only: [:new, :create]
  end

  get "up" => "rails/health#show", as: :rails_health_check
end

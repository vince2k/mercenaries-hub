Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :bookings, only: [:index, :destroy] do
    member do
      patch :toggle_status
      patch :assign
      patch :cancel
    end
    resources :reviews, only: [:new, :create, :index, :edit, :update]
  end

  resources :mercenaries, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    collection do
      get :my_mercenaries
    end
    resources :bookings, only: [:new, :create, :edit, :update]
  end

  get "up" => "rails/health#show", as: :rails_health_check
end

Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :mercenaries, only: [:new, :create, :index] do
    resources :bookings, only: [:new, :create, :index]
  end

  get "up" => "rails/health#show", as: :rails_health_check
end

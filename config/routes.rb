Rails.application.routes.draw do
  devise_for :users
  root to: 'application#index'

  resources :events do
    resources :tickets
  end

  get "tickets/all"
  get "money/index"

  resources :money
end

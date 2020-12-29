Rails.application.routes.draw do
  resources :plants, only: :index
  root to: 'plants#index'
end

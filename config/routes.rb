Rails.application.routes.draw do
  resources :plants, only: [:index, :show]
  root to: 'plants#index'
end

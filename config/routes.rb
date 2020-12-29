Rails.application.routes.draw do
  resources :plants, only: :index
end

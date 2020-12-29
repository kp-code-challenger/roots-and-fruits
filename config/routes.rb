Rails.application.routes.draw do
  resources :searches, only: :index
end

Rails.application.routes.draw do
  namespace :api do
    resources :documents, only: [:index, :create]
  end
end

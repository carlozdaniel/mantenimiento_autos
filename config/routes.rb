Rails.application.routes.draw do
  devise_for :users

  # API routes
  namespace :api do
    namespace :v1 do
      resources :cars do
        resources :maintenance_services
      end
    end
  end

  # Regular routes for views
  resources :cars do
    resources :maintenance_services, only: [ :index, :new, :create, :show, :edit, :update, :destroy ]
  end

  root "cars#index"
end

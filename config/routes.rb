Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :cars
      resources :maintenance_services
    end
  end

  resources :cars do
    resources :maintenance_services, only: [ :index, :new, :create ]
  end

  root "cars#index"
end

Rails.application.routes.draw do
  resources :price_discrepancy_reports, only: [:index, :create]

  root to: 'static#index'
end

Rails.application.routes.draw do
  root to: 'static#index'
  get '/report', to: 'price_discrepancy_reports#show'
end

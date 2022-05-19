Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get '/items', to: 'items#index'
      get '/items/:id', to: 'items#show'
      get '/merchants', to: 'merchants#index'
      get '/merchants/:id', to: 'merchants#show'
      get '/merchants/:id/items', to: 'merchant_items#index', as: :specific_merchant_items
    end
  end
end

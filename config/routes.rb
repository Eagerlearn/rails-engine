Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get '/items', to: 'items#index'
      get '/items/:id', to: 'items#show'
      put '/items/:id', to: 'items#update'
      post '/items', to: 'items#create'
      delete '/items/:id', to: 'items#destroy'

      get '/items/:id/merchant', to: 'item_merchant#index'

      get '/merchants', to: 'merchants#index'
      get '/merchants/:id', to: 'merchants#show'
      get '/merchants/:id/items', to: 'merchant_items#index'
    end
  end
end

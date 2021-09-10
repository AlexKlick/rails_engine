Rails.application.routes.draw do

  namespace 'api' do
    namespace 'v1' do

      namespace 'merchants' do
        resource :most_items, only: :show
        resource :find, only: :show
      end
      namespace 'items' do
        resource :find_all, only: :show
      end
      namespace 'revenue' do
        resources :merchants, only: [:index, :show]
        resources :items, only: :index
      end

      resources :items, controller: 'items' do
        get '/merchant', to: 'items/merchants#show'
      end
      resources :merchants, only: [:index, :show] do 
        resources :items, only: :index, controller: 'merchants/items'
      end

    end
  end
end

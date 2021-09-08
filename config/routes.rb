Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace 'api' do
    namespace 'v1' do
      namespace 'revenue' do
        resource :merchants
      end
      namespace 'merchants' do
        resource :find
      end
      namespace 'items' do
        resource :find_all
      end
      resources :items, controller: 'items'
      resources :merchants, only: [:index, :show] do 
        resources :items
      end
    end
  end
 
end

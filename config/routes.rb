Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope 'api/v1' do
    resources :merchants, only: [:index, :show] do 
      resources :items
    end
  end
  scope 'api/v1' do
    resources :items, controller: 'items'
  end
 
end
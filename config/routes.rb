Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root     'welcome#index'
  resources :users 
  resources :sessions, only: [:new, :create, :destroy]
  resources :restaurants do
    resources :reservations
  end
end

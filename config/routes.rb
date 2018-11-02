Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :categories do
    resources :pizzas do
      resources :orders
    end
  end

  get 'pizzas', to: 'categories#all_pizzas'
  get 'orders', to: 'orders#index'
  put 'orders/:id', to: 'orders#update'

  root to: 'categories#all_pizzas'
end

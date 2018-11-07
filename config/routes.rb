Rails.application.routes.draw do
  devise_for :user, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  resources :categories do
    resources :pizzas do
      resources :cart
      resources :orders
    end
  end

  get 'pizzas', to: 'categories#all_pizzas'

  get 'orders', to: 'orders#index'
  get 'user_orders', to: 'orders#user_orders'
  put 'orders/:id', to: 'orders#update'

  get 'feedback', to: 'feedbacks#index'
  post 'feedback', to: 'feedbacks#create'

  get 'cart', to: 'cart#index'

  post 'create_admin', to: 'admin#create_admin'

  root to: 'categories#all_pizzas'
end

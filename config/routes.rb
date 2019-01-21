Rails.application.routes.draw do
  devise_for :user, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  resources :categories do
    resources :pizzas, only: %i[create index]
  end
  resources :pizzas, only: %i[update destroy show] do
    resources :orders, only: %i[create index]
  end
  resources :orders, only: %i[update show]

  get 'all_pizzas', to: 'categories#all_pizzas'

  get 'orders', to: 'orders#index'
  get 'user_orders', to: 'orders#user_orders'
  put 'orders/:id', to: 'orders#update'

  get 'feedback', to: 'feedbacks#index'
  post 'feedback', to: 'feedbacks#create'

  get 'cart', to: 'cart#index'
  get 'cart/:id', to: 'cart#show'
  delete 'cart/:id', to: 'cart#destroy'
  post 'pizzas/:id/cart', to: 'cart#create'

  post 'create_admin', to: 'admin#create_admin'
  post 'change_password', to: 'users#change_password'
  post 'activate_account', to: 'users#activate_account'
  post 'forgot_password', to: 'users#forgot_password'

  get '/' => redirect('/categories')
end

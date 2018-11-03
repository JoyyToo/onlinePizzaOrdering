Rails.application.routes.draw do
  devise_for :user, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  resources :categories do
    resources :pizzas do
      resources :orders
    end
  end

  get 'pizzas', to: 'categories#all_pizzas'

  get 'orders', to: 'orders#index'
  put 'orders/:id', to: 'orders#update'

  get 'feedback', to: 'feedbacks#index'
  post 'feedback', to: 'feedbacks#create'

  root to: 'categories#all_pizzas'
end

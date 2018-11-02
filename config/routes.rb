Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :categories do
    resources :pizzas do
    end
  end

  get 'pizzas', to: 'categories#all_pizzas'

  root to: 'categories#all_pizzas'
end

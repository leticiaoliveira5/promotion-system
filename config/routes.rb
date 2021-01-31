Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
root 'home#index'
resources :promotions, only: %i[index show new create edit update destroy]
resources :product_categories, only: %i[index new create edit show]
end

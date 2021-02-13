Rails.application.routes.draw do
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

root 'home#index'

devise_for :users

resources :promotions, only: %i[index show new create edit update destroy] do
  post 'generate_coupons', on: :member

  member do
    post 'generate_coupons'
    post 'approve'
  end

end

resources :product_categories, only: %i[index new create edit show]

resources :coupons, only: [] do
  post 'inactivate', on: :member
  post 'activate', on: :member
end

end

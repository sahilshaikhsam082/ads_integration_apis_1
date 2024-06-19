Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resource :user, only: [:edit, :update]
  get 'profile_updated', to: 'users#profile_updated', as: :profile_updated

end


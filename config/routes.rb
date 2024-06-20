Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resource :user, only: [:edit, :update]
  get 'profile_updated', to: 'users#profile_updated', as: :profile_updated
  resources :ad_companies, only: [:index] do
    collection do
      post :connect
    end
    member do
      get :fetch_tiktok_ad_accounts
    end
  end
  get 'tiktok/auth', to: 'tiktok#auth'
  get 'tiktok/callback', to: 'tiktok#callback'
  resources :tiktok_accounts, only: [] do
    member do
      get :fetch_ad_accounts
    end
  end
  get 'facebook/auth', to: 'facebook#auth'
  get 'facebook/callback', to: 'facebook#callback'
end


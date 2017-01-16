Rails.application.routes.draw do
  root to: 'static_pages#home'
  get    'signup', to: 'users#new'
  get    'login',  to: 'sessions#new'
  post   'login',  to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get    'taglist', to: 'voices#index'

  resources :users do
    member do
      get :followings, :followers, :favorites, :show_message
      post :create_message
    end
  end
  resources :voices do
    resource :favorites, only: [:create, :destroy]
    member do
      get :favorites_user
      post :share, :create_comment
    end
  end
  resources :relationships, only: [:create, :destroy]
end

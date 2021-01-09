Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root to: 'homes#top'
  get '/about', to: 'homes#about'
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }

  devise_scope :user do
    get "sign_in", :to => "users/sessions#new"
    get "sign_out", :to => "users/sessions#destroy"
  end

  resources :users, only: [:show, :edit, :update] do
    resources :murmurs, only: [:create, :destroy]
    resource :relationships, only: [:create, :destroy]
  end

  resources :posts do
    resource :favorites, only: [:create, :destroy]
    resources :reviews, only: [:create, :destroy]
  end

  resource :contacts, only: [:new, :create]

  get '/unsubscribe', to: 'users#unsubscribe', as: 'unsubscribe'
  patch '/withdraw', to: 'users#withdraw', as: 'withdraw'
  get '/withdraw', to: 'homes#top'
  get '/users/:id/followings', to: 'users#followings', as: 'followings'
  get '/users/:id/followers', to: 'users#followers', as: 'followers'

end

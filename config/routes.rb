Rails.application.routes.draw do
  devise_for :users
  get 'homes/top'
  get 'homes/about'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root to: 'homes#top'

end

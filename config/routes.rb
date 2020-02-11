Rails.application.routes.draw do
  root 'top#index'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: "users/registrations"
  }
  # devise_for :users
  # ユーザープロフィール画面は独自に作成する
  resources :users, only: [:show]

  resources :ooyas
  resources :buildings
end

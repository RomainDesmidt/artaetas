Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'social', to: 'pages#social'
  get 'annonces', to: 'annonces#index'
  get 'annonces/new', to: 'annonces#new'
  post 'annonces', to: 'annonces#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

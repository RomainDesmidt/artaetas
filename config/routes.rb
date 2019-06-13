Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'social', to: 'pages#social'
  get 'annonces', to: 'annonces#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  devise_for :users
  root to: 'annonces#index'
  resources :annonces
  get 'social', to: 'pages#social'
  # get 'annonces', to: 'annonces#index'
  # get 'annonces/new', to: 'annonces#new'
  # post 'annonces', to: 'annonces#create'
  get  'searchannonce', to: 'annonces#search'
  # get 'annonces/:id', to: 'annonces#show'
  get 'users/me', to: 'users#me'
  get 'users/:id', to: 'users#show'
  get 'users', to: 'users#index'
  # get "annonces/:id/edit", to: "annonces#edit"
  # patch "annonces/:id", to: "annonces#update"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

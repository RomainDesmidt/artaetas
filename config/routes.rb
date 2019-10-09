Rails.application.routes.draw do
  devise_for :users, :controllers => { omniauth_callbacks: "users/omniauth_callbacks", registrations: 'registrations' }
  root to: 'annonces#index'
  resources :annonces do
    member do
        put "like", to: "annonces#like"
        put "dislike", to: "annonces#dislike"
        put "likeuser", to: "annonces#likeuser"
        put "dislikeuser", to: "annonces#dislikeuser"
        put "follow", to: "annonces#follow"
        put "unfollow", to: "annonces#unfollow"
        put "bookmark", to: "annonces#bookmark"
        put "unbookmark", to: "annonces#unbookmark"
        put "destroy_photo_un", to: "annonces#destroy_photo_un"
        put "destroy_photo_deux", to: "annonces#destroy_photo_deux"
    end
end
  # resources :annonces
  get 'social', to: 'pages#social'
  # get 'annonces', to: 'annonces#index'
  # get 'annonces/new', to: 'annonces#new'
  # post 'annonces', to: 'annonces#create'
  get  'searchannonce', to: 'annonces#search'
  # get 'annonces/:id', to: 'annonces#show'
  get 'users/me', to: 'users#me'
  get 'users/:id', to: 'users#show'
  get 'users', to: 'users#index'
  # put "like", to: "annonces#like"
  # put "dislike", to: "annonces#dislike"

  # get "annonces/:id/edit", to: "annonces#edit"
  # patch "annonces/:id", to: "annonces#update"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

   # static pages
  get 'styleguide', to: 'pages#styleguide'
end

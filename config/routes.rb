Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  get '/admin/orders/pdfshow/:id', to: 'admin/orders#pdfshow', as: :admin_orders_pdfshow
  ActiveAdmin.routes(self)
  devise_for :users, :controllers => { omniauth_callbacks: "users/omniauth_callbacks", registrations: 'registrations' }
  # as :user do
  #   get 'users/me?view_param=annonce', :to => 'users#me', :as => :user_root
  # end

  root to: 'annonces#index'
  resources :annonces, except: [:show] do
    member do
        put "like", to: "annonces#like"
        put "dislike", to: "annonces#dislike"
        put "likeuser", to: "annonces#likeuser"
        put "dislikeuser", to: "annonces#dislikeuser"
        put "follow", to: "annonces#follow"
        put "unfollow", to: "annonces#unfollow"
        put "followuser", to: "annonces#follow_user"
        put "unfollowuser", to: "annonces#unfollow_user"
        put "bookmark", to: "annonces#bookmark"
        put "unbookmark", to: "annonces#unbookmark"
        put "destroy_photo_un", to: "annonces#destroy_photo_un"
        put "destroy_photo_deux", to: "annonces#destroy_photo_deux"
        get "edit_formule", to: "annonces#edit_formule"
        patch "update_formule", to: "annonces#update_formule"
        get "contact_user", to: "annonces#contact_user"
        patch "contact_deliver", to: "annonces#contact_deliver"
    end
  end
  get "annonces/:slug", to: "annonces#show", as: :showannonces
  resources :orders, only: [:create] do
    resources :payments, only: :new
  end
  get "orders/:slug/:id", to: "orders#show", as: :facturepdf
  # resources :annonces
  get 'social', to: 'pages#social'
  get 'cgu', to: 'pages#cgu'
  get 'faq', to: 'pages#faq'
  get 'quisommesnous', to: 'pages#quisommesnous'
  get 'politiquedeconfidentialite', to: 'pages#politiquedeconfidentialite'
  # get 'annonces', to: 'annonces#index'
  # get 'annonces/new', to: 'annonces#new'
  # post 'annonces', to: 'annonces#create'
  get  'searchannonce', to: 'annonces#search'
  # get 'annonces/:id', to: 'annonces#show'
  get 'users/me', to: 'users#me'
  get 'users/mesannonces', to: 'users#mesannonces'
  get 'users/mesfavoris', to: 'users#mesfavoris'
  get 'users/mesinfos', to: 'users#mesinfos'
  get 'users/mestransactions', to: 'users#mestransactions'
  # get 'users/:id', to: 'users#show', as: :profil
  get 'users/:username', to: 'users#show', as: :profil, constraints: { username: /[^\/]+/ }
  get 'users', to: 'users#index'
  get 'testindex', to: 'annonces#index2'
  get 'changelog', to: 'pages#changelog'
  get 'mentionslegales', to: 'pages#mentionslegales'
  get 'imglist', to: 'pages#imglist'
  # put "like", to: "annonces#like"
  # put "dislike", to: "annonces#dislike"

  # get "annonces/:id/edit", to: "annonces#edit"
  # patch "annonces/:id", to: "annonces#update"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

   # static pages
  get 'sidekiqtest', to: 'pages#sidekiqtest'
  get 'styleguide', to: 'pages#styleguide'
  mount StripeEvent::Engine, at: '/stripe-webhooks'
  
end

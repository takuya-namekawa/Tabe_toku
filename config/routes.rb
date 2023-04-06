Rails.application.routes.draw do

  namespace :admin do
    get 'admins/show'
    get 'admins/edit'
  end
  namespace :public do
    get 'cart_items/index'
  end
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admins, skip: [:passwords], controllers: {
    registrations: "admin/registrations",
    sessions: "admin/sessions"
  }


  
  scope module: :public do
    root to: "homes#top"
    resources :customers, only: [:edit, :update] do
      collection do
        get "my_page" => "customers#show"
        get "favorites"
      end
    end
    resources :items, only: [:index, :show] do
      get "/genre_items" => "items#genre_items"
      resources :item_comments, only: [:create, :destroy]
      collection do
        get "search"
      end
    end
    resources :cart_items, only: [:index, :update, :destroy, :create] do
      collection do
        delete "all_destroy"
      end
    end
    get "orders/responsive" => "orders#responsive", as: "responsive"
    get "orders/confirm" => "orders#confirm", as: "confirm"
    get "orders/thanks" => "orders#thanks", as: "thanks"
    resources :orders, only: [:new, :create, :index, ]
    resources :admins, only: [:show] do
      resource :favorites, only: [:create, :destroy]
      collection do
        get "shops" => "admins#index"
      end
    end
  end
  
  namespace :admin do
    resources :admins, only: [:edit, :update] do
      collection do
        get "my_page" => "admins#show"
      end
    end
    resources :items, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :genres, only: [:index, :create, :edit, :update, :destroy]
    resources :reserves, only: [:index, :show, :create, :update]
    resources :customers, only: [:edit, :show, :update] do
      patch "out"
    end
    resources :notifications, only: :index do
      get "join" => "notifications#join"
      get "new/mail" => "notifications#new_mail"
      get "send/mail" => "notifications#send_mail"
    end
  end

end

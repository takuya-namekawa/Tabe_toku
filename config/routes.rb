Rails.application.routes.draw do

  namespace :public do
    get 'items/index'
    get 'items/show'
  end
  namespace :public do
    get 'customers/show'
    get 'customers/edit'
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
    resources :items, only: [:index, :new, :create, :edit, :destroy, :update]
    resources :genres, only: [:index, :create, :edit, :update, :destroy]
  end

end

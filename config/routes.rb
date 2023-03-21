Rails.application.routes.draw do

  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admins, skip: [:passwords], controllers: {
    registrations: "admin/registrations",
    sessions: "admin/sessions"
  }


  namespace :admin do
    resources :items, only: [:index, :new, :create, :edit, :destroy, :update]
  end
  scope module: :public do
    root to: "homes#top"
  end


end

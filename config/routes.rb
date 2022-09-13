Rails.application.routes.draw do
  
  devise_for :customers,skip: [:passwords,], controllers: {
    registrations: "customer/registrations",
    sessions: 'customer/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    get "/" => "homes#top"
    resources :orders
    resources :customers
    resources :genres
    resources :items
  end
  
  scope module: :customer do
    root to: "homes#top"
    get "/about" => "homes#about"
    get "/customers/my_page" => "customers#show"
    get "/customers/information/edit" => "customers#edit"
    patch "/customers/information" => "customers#update"
    get "/customers/deactivate" => "customers#deactivate"
    patch "/customers/withdraw" => "customers#withdraw"
    resources :items
    resources :cart_items
    delete :cart_items, to: 'cart_items#destroy_all'
    resources :orders
    resources :addresses
  end
end
Cart::Application.routes.draw do
  devise_for :members
  resources :products, :only => [:index, :show]
  resources :orders, :only => [:create] do
  	collection do
  		get "cart", "check", "finish"
  	end
  end

  namespace :service do
    resources :orders, :only => [:index, :show]
    root :to => "orders#index"
  end
  
  namespace :admin do
    get "login", "logout"
    match "checkAdmin", :via => :post

    resources :products
    resources :orders, :only => [:index, :show, :update]
    root :to => "products#index"
  end

  root :to => "products#index"
end

Cart::Application.routes.draw do
  devise_for :members, :controllers => { :sessions => "sessions", :registrations => "registrations" }
  resources :products, :only => [:index, :show]
  resources :orders, :only => [:create] do
  	collection do
  		get "cart", "check", "finish"
  	end
  end

  namespace :service do

    resources :orders, :only => [:index, :show, :update] do
      member do
        match "refund", :via => :post
      end
    end

    resources :points, :only => [:index]

    resources :addressbooks, :only => [:index, :create, :update, :destroy]
    resources :tracebooks
    root :to => "orders#index"
  end
  
  namespace :admin do
    get "login", "logout"
    match "checkAdmin", :via => :post

    get "members" => "members#index"

    resources :products, :only => [:index, :edit, :create, :update] do
      member do
        get "stock"
        match "saveStock", :via => :post
        match "enable", :via => :post
        match "disable", :via => :post
      end
    end

    resources :orderrefunds, :only => [:index, :show]
    resources :orders, :only => [:index, :show, :update] do
      namespace :changestatus do
        match "check", :via => :post
        match "processing", :via => :post
        match "deliver", :via => :post
        match "cancel", :via => :post
      end
    end
    
    root :to => "products#index"
  end

  root :to => "products#index"
end

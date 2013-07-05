Cart::Application.routes.draw do
  devise_for :members, :controllers => { :sessions => "sessions", :registrations => "registrations" }
  resources :products, :only => [:index, :show]
  resources :orders, :only => [:create] do
  	collection do
      namespace :cart do
        match "add" => "cart#add" , :via => :post
        match ":stock_id/plus" => "cart#plus" , :via => :post, :as => "plus"
        match ":stock_id/minus" => "cart#minus" , :via => :post, :as => "minus"
        match ":stock_id/delete" => "cart#delete" , :via => :post, :as => "delete"

        root :to => "cart#show"
      end

      get "check", "finish"
  	end
  end

  namespace :service do
    resources :orders, :only => [:index, :show, :update] do
      member do
        match "refund", :via => :post
      end
    end

    resources :points, :only => [:index]

    resources :addressbooks, :only => [:index, :create, :destroy]
    #resources :tracebooks
    root :to => "orders#index"
  end
  
  namespace :admin do
    get "login", "logout"
    match "checkAdmin", :via => :post

    resources :members, :only => [:index]

    resources :products, :only => [:index, :edit, :create, :update] do
      member do
        match "enable", :via => :post
        match "disable", :via => :post
      end

      resources :stocks, :only => [:index, :create, :destroy] do
        collection do
          match "updateStocks", :via => :post
        end
      end
    end

    resources :orderrefunds, :only => [:index] do
      member do
        match "done", :via => :post
      end
    end

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

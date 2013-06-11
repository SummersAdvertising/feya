Cart::Application.routes.draw do
  devise_for :members
  resources :products, :only => [:index, :show]
  resources :orders, :only => [:create] do
  	collection do
  		get "cart", "check", "finish"
  	end
  end
  
  namespace :admin do
    get "login", "logout"
    match "checkAdmin", :via => :post

    resources :products
    root :to => "products#index"
  end

  root :to => "products#index"
end

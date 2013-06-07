Cart::Application.routes.draw do
  resources :products, :only => [:index, :show]
  
  namespace :admin do
    get "login", "logout"
    match "checkAdmin", :via => :post

    resources :products
    root :to => "products#index"
  end

  root :to => "products#index"
end

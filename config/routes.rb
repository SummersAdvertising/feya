Feya::Application.routes.draw do

  resources :articles
  resources :photos

  resources :testimonies

  resources :entries
  resources :instructions do
  	resources :testimonies

  	resources :courses do
      collection do
        get :link
        get :link_ask
      end
	  resources :inquirements
  	end
  end

  resources :categories do
  	resources :products, :only => [:show]
  end

  resources :tickets

  resources :pages, :controller => :static_pages, :action => :show do
  	collection do
  		get ':pagename', :as => :page
  	end

  end

  match 'articles/:id/uploadPhoto' => 'articles#createPhoto', :via => [:post]
  match 'articles/:artid/deletePhoto/:id' => 'articles#destroyPhoto', :via => [:delete]

  devise_for :members, :controllers => { :sessions => "sessions", :registrations => "registrations", :passwords => "passwords" }

  resources :orders, :only => [:create] do
  	collection do
      namespace :cart do
        match "add" => "cart#add" , :via => :post
        match ":stock_id/plus" => "cart#plus" , :via => :post, :as => "plus"
        match ":stock_id/minus" => "cart#minus" , :via => :post, :as => "minus"
        match ":stock_id/delete" => "cart#delete" , :via => :delete, :as => "delete"

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

  	match 'peditor/:id/createPhoto' => 'peditor#createPhoto', :via => [:post]

    get "login", "logout"
    match "checkAdmin", :via => :post

    resources :members, :only => [:index, :destroy]

    resources :tickets, :only => [ :index, :show, :destroy ]

    resources :admins

    resources :drafts

    resources :categories  do

	    resources :products, :only => [:index, :new, :edit, :create, :update, :destroy] do
	      member do
	        match "enable", :via => :post
	        match "disable", :via => :post
	  		get :restore
	      end

	      resources :stocks, :only => [:index, :create, :destroy] do
	        collection do
	          match "updateStocks", :via => :post
	        end
	      end
	    end

    end

	resources :articles

	resources :inquirements

	resources :entries

    resources :instructions do
		resources :testimonies

	  	resources :courses do
		  	resources :inquirements
	  		member do
	  			get :switch
	  			get :restore
	  		end
	  	end
    end


    resources :orderrefunds, :only => [:index] do
      member do
        match "done", :via => :post
      end
    end

    resources :orders, :only => [:index, :show, :update] do

      collection do
      	post :expire
      end

      namespace :changestatus do
        match "check", :via => :post
        match "processing", :via => :post
        match "deliver", :via => :post
        match "cancel", :via => :post
      end
    end

    root :to => "categories#index"
  end

  root :to => "static_pages#index"

end

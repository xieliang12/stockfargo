Rails.application.routes.draw do
  mount Upmin::Engine => '/admin'
  devise_for :users
  resources :users
  get "home/index"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  #resources :screener
  #get '/screener'
  authenticated :user do
    root :to => "visitors#authorized_index", :as => "authorized_root"
  end
  root to: 'visitors#index'
  
  resources :portfolios do
    get 'holdings/all/edit' => 'holdings#edit_all', :as => :edit_all
    match 'holdings/all' => 'holdings#update_all', :as => :update_all, :via => :put
    member do
      get 'basic'
      get 'transactions'
    end
    resources :transactions
    resources :holdings do
      get :autocomplete_stock_symbol, :on => :collection
    end
  end

  resources :favorites do
    get :autocomplete_stock_symbol, :on => :collection
    resources :posts
    resources :researches
  end
  
  get 'tags/:tag', to: 'favorites#index', as: :tag

  resources :stocks
  get '/stocks' => 'stocks#index'
  get '/stocks/:id' => 'stocks#show'
  
  resources :reports do
    post 'results' => 'reports#index', :on => :collection
  end
  
end

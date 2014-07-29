Btfoto::Application.routes.draw do
  
  root to: 'pages#index'
  
  resources :cart_items, only: [:create] do
    collection do
      delete :delete_multiple
      delete :destroy_multiple
      put :update_multiple
    end
  end
  
  get 'nyheter', to: 'news#index', as: 'news_index'
  get 'nyheter/:id', to: 'news#show', as: 'news'
  
  resources :orders, only: [:create]
  resources :appointments, only: [:index, :edit, :update]
    
  get 'store', to: 'store#index'#, as: 'store'
  get 'store/show_product', to: 'store#show_product'
  get 'store/checkout', to: 'store#checkout', as: 'store_checkout'
  get 'store/payment', to: 'orders#new'
  get 'store/payment_return', to: 'payments#create'
  get 'store/login', to: 'store#login'#, as: 'store_login'
  get 'store/logout', to: 'store#logout'#, as: 'store_logout'
  post 'store/auth', to: 'store#auth'
  get 'store/success', to: 'store#success'
  
  #Byta bildnummer
  get 'store/edit_image', to: 'store#edit_image'
  post 'store/update_image', to: 'store#update_image'
  get 'store/switch_image', to: 'store#switch_image'
  
  post 'store/add_to_cart', to: 'cart_items#create', as: 'add_to_cart'
  post 'store/empty_cart', to: 'cart_items#destroy', as: 'empty_cart'
  
  get 'store/:id', to: 'store#show', as: 'product'
  
  namespace :admin do
    root to: 'dashboard#index'
    resources :pages do
      get 'move_higher', to: 'pages#move_higher', as: 'move_higher'
      get 'move_lower', to: 'pages#move_lower', as: 'move_lower'
    end
    resources :products
    resources :product_categories
    resources :orders do
      get :mark_as_printed
    end
    resources :pictures
    resources :customers
    resource :session, only: [:new, :create, :destroy]
    resources :users, only: [:new, :create, :index, :destroy]
    
    resources :news, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :appointments, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :galleries do
      get 'move_higher', to: 'galleries#move_higher', as: 'move_higher'
      get 'move_lower', to: 'galleries#move_lower', as: 'move_lower'
    end
        
    get 'login', to: 'sessions#new', as: 'login'
    get 'logout', to: 'sessions#destroy', as: 'logout'
    get 'signup', to: 'users#new', as: 'signup'
  end 
  
  get '/:id' => 'pages#show'
  
  get '(*app)' => 'pages#redirect'
  get '(*uppdrag)' => 'pages#redirect'
  get '(*konfirmation)' => 'pages#redirect'
  get '(*bildspel)' => 'pages#redirect'
  get '(*photos)' => 'pages#redirect'
  get '(*mig)' => 'pages#redirect'
  
end

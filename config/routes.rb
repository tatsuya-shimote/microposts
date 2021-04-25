Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :create] do
    #user/:idを継承した上でのrouteingを定義。つまり特定のuserに関する操作の準備
    member do
      get :followings
      get :followers
    end
    #userのみを継承した上でrouteingを定義。つまり全userに対する（もしくはそれを利用した）操作の準備。
    collection do
      get :search
    end
  end

  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
end

Rails.application.routes.draw do
  # root 'welcome#index'
  root 'posts#index'
  
  get '/homepage', to: 'posts#index'
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'


  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  resources :users

  resources :posts do
    resources :comments, except: [:index, :show] do
      #добавление дополнительного маршрута к comments
      member do
        get :reply
      end
    end
    resources :likes
  end
  resources :comments

  resources :tags



  # get '/handbook', to: 'welcome#handbook'

  # get '/submit_news', to: 'news_items#new'
  # get '/submit_post', to: 'microposts#new'

  # resources :tags 

  # mount ActionCable.server => '/cable'
end

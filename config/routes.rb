Rails.application.routes.draw do
  # root 'welcome#index'
  root 'posts#index'
  get '/homepage', to: 'posts#index'
  resources :posts


  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users
  resources :posts do
    resources :comments, except: [:index, :show] do
      #добавление дополнительного маршрута к comments
      member do
        get :reply
      end
    end
  end

  resources :comments
  # get '/handbook', to: 'welcome#handbook'

  # get '/signup', to: 'users#new'
  # post '/signup', to: 'users#create'

  # get '/submit_news', to: 'news_items#new'
  # get '/submit_post', to: 'microposts#new'



  # get '/login', to: 'sessions#new'
  # post '/login', to: 'sessions#create'
  # delete '/logout', to: 'sessions#destroy'

  # resources :users
  # resources :posts do
  #   resources :comments, except: [:index, :show] do
  #     member do
  #       get :reply
  #     end
  #   end
  # end
  
  # resources :news_items
  # resources :tags 

  # mount ActionCable.server => '/cable'
end

Rails.application.routes.draw do

  root 'posts#index'
  resources :posts do
    resources :comments
    #resources :votes, only: [:create, :show, :update, :destroy]
    post '/votes/up' => 'votes#up'
    post '/votes/down' => 'votes#down'
    #delete '/posts/:post_id/votes/clear' => 'votes#vote_clear'
  end
resources :tags
resources :users
resources :topics

get 'signup', to: 'users#new', as: 'signup'
get 'login', to:'session#new', as: 'login'
post 'login', to: 'session#create', as: 'sessions'
post 'logout', to: 'session#destroy', as: 'logout'
end

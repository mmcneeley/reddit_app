Rails.application.routes.draw do
resources :posts do
  resources :comments
end
resources :users

get 'signup', to: 'users#new', as: 'signup'
get 'login', to:'session#new', as: 'login'
post 'login', to: 'session#create', as: 'sessions'
post 'logout', to: 'session#destroy', as: 'logout'
end

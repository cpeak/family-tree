Family::Application.routes.draw do


  root :to => 'pages#home'

  resources :notes
  resources :marriages
  resources :people


  get '/tree' => 'pages#tree'
  get '/todo' => 'pages#todo'
  get '/about' => 'pages#about'
  get '/login' => 'pages#login'
  get '/photos' => 'pages#photos'


end

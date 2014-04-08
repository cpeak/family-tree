Family::Application.routes.draw do


  root :to => 'pages#home'

  resources :notes
  resources :marriages
  resources :people


  get '/tree' => 'pages#tree'
  get '/todo' => 'pages#todo'


  get "pages/index"
  get "pages/about"
  get "pages/todo"

end

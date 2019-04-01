Rails.application.routes.draw do

  get 'help' => 'home#help'

  post 'likes/:id/create' => 'likes#create'
  post 'likes/:id/destroy' => 'likes#destroy'

  post 'logout' => 'users#logout'
  post 'login' => 'users#login'
  get 'login' => 'users#login_form'

  get 'users/:id/likes' => 'users#likes'
  get 'users/:id/answers' => 'users#answers'

  post 'users/:id/update' => 'users#update'
  get 'users/:id/edit' => 'users#edit'
  post 'users/create' => 'users#create'
  get 'signup' => 'users#new'
  get 'users/index' => 'users#index'
  get 'users/:id' => 'users#show'

  post 'answers/:id/destroy' => 'answers#destroy'
  post 'answers/:id/update' => 'answers#update'
  get 'answers/:id/edit' => 'answers#edit'
  post 'answers/:id/create' =>  'answers#create'

  post 'questions/:id/destroy' => 'questions#destroy'
  post 'questions/:id/update' => 'questions#update'
  get 'questions/:id/edit' => 'questions#edit'
  post 'questions/create' => 'questions#create'
  get 'questions/new' => 'questions#new'
  get 'questions/index' => 'questions#index'
  get 'questions/:id' => 'questions#show'

  get '/' => 'home#top'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

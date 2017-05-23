Rails.application.routes.draw do

  get '/todos', to: 'todos#index'
  get '/todos/:id', to: 'todos#show'
  post '/todos', to: 'todos#create'
  put '/todos/:id', to: 'todos#update'
  put '/todos/:id/done', to: 'todos#done'
  delete '/todos/:id', to: 'todos#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

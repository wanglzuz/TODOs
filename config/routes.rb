Rails.application.routes.draw do
  #Tohle je moc fajn. Jedine co je trosku blby je, ze mas tim padem dve identicke readme. Jak bys mohla zaridit to, aby se to readme nacitalo a prezentovalo z README.md a nemuselas ho duplikovat jako sablonu? (hint: nacitani souboru v kontrolleru a pak jejich dump v renderu - melo by to fungovat)
  get '/', to: 'home#about'

  get '/todos', to: 'todos#index'
  get '/todos/:id', to: 'todos#show'
  post '/todos', to: 'todos#create'
  put '/todos/:id', to: 'todos#update'
  put '/todos/:id/done', to: 'todos#done'
  delete '/todos/:id', to: 'todos#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  post 'users/:id' => 'users#show'
  get 'home/about'=>'home#about'
  match '/about',to:'home#about',via: 'get'
  
  resources :books,only: [:new, :create, :index, :show, :destroy,:edit,:update]
  resources :users, only: [:show, :edit,:update,:index]
  patch '/books/:id',to:'books#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

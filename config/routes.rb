Rails.application.routes.draw do
 
  get 'messages/new'
  get 'messages/create'
  get 'messages/show'
  get 'chats/:id', to: "chats#show", as: "chat"
  resources :chats, only: [:create]
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  root to: "homes#top"
  get "home/about"=>"homes#about"
  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resources :post_comments, only: [:create,:destroy]
    resource :favorites, only: [:create,:destroy]
  end
  resources :groups, only: [:new,:create,:edit,:update,:index,:show] do
     resources :messages,only: [:new,:index,:create,:show]
    get "join" => "groups#join"
   
  end
  resources :users, only: [:index,:show,:edit,:update] do
    get "search",to: "users#search"
    resource :relationships,only: [:create,:destroy]
    # フォロー一覧
    get :followings, on: :member
    # フォロワー一覧
    get :followers, on: :member
  end
  
  get "search" => "searches#search" 
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  devise_for :users
  root "posts#index"
  resources :ratings,only:[:new,:create,:edit]

  resources :posts, only:[:new,:create, :show,:edit,:destroy,:update] 
  
end

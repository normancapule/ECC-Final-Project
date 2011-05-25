ECCFinalProject::Application.routes.draw do
  resources :logs

  resources :ratings

  resources :tags

  resources :userprojects

  resources :releases

  resources :comments

  resources :stories

  resources :projects

  root :to => "home#index"

  devise_for :users

end

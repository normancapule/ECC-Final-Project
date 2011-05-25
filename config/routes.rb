ECCFinalProject::Application.routes.draw do
  resources :releases

  resources :comments

  resources :stories

  resources :projects

  root :to => "home#index"

  devise_for :users
end

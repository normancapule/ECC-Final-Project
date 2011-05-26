ECCFinalProject::Application.routes.draw do
  #sresources :logs

  #resources :ratings

  #resources :tags

  #resources :comments

  resources :projects do
    resources :releases
    resources :stories
    resources :userprojects
  end
  
  root :to => "home#index"

  devise_for :users

end

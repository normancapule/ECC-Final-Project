ECCFinalProject::Application.routes.draw do
  #resources :logs
  #resources :ratings


  resources :projects do
    resources :releases
    resources :stories do 
        resources :comments, :only => [:create, :update, :destroy]
        resources :ratings
    end
    resources :userprojects
  end
  
  root :to => "home#index"

  devise_for :users
end

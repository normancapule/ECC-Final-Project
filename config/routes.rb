ECCFinalProject::Application.routes.draw do
  resources :logs
  
  resources :system_user
  
  resources :projects do
    get 'restore'
    resources :releases
    resources :stories do 
      get 'start'
      get 'finish'
      get 'hold'
      get 'accept'
      get 'reject'
      resources :comments, :only => [:create, :update, :destroy]
      resources :ratings
      resources :tags
    end
    resources :userprojects
  end
  
  root :to => "home#index"

  devise_for :users
  
  
  
  
end

Rails.application.routes.draw do
  
  get 'welcome/index'


  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  resources :lectures do 
    collection do 
      post 'create_comment', :action  => 'create_comment'
      post'new' , :action =>'create'
      post'new' , :action =>'render_422'
end
  member do
    put "like", to: "lectures#upvote"
    put "dislike", to: "lectures#downvote"
    put "spam" => 'lectures#set_spammed'
    put "unspam" => 'lectures#set_unspammed'
  end
end

get '/lectures', to: 'lectures#index', as: 'lectures_path'

  mount Ckeditor::Engine=>'/ckeditor'    
  resources :courses  
      devise_for :users
      


  root 'welcome#index'

  
end

Rails.application.routes.draw do
  devise_for :users,
             controllers: {
               sessions: 'users/sessions',
               registrations: 'users/registrations'
             }
  get '/member-data', to: 'members#show'
  put "users/:id/avatar", to:"users#update_avatar"
  resources :users, except: [:new]
  # post "/signup", to: "users#create"
  resources :singers
  post "/singer/signup", to:"singers#create"
  get "videos/public", to:"videos#show_public_videos"
  post "videos/:id/thumbnails", to:"videos#update_thumbnails"
  put "videos/:id/views", to:"videos#update_views"
  resources :videos

  post "feelings/check", to:"feelings#check_feelings"
  resources :feelings

  post "subscribes/check", to:"subscribes#check_subscribes"
  resources :subscribes

  get "comments/videos", to:"comments#show_comments"
  resources :comments

  resources :histories
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

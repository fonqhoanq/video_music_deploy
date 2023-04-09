Rails.application.routes.draw do
  devise_for :singers,
  controllers: {
    sessions: 'singers/sessions',
    registrations: 'singers/registrations'
  }
  devise_for :users,
             controllers: {
               sessions: 'users/sessions',
               registrations: 'users/registrations'
             }
  get '/member-data', to: 'members#show'
  put "users/:id/avatar", to:"users#update_avatar"
  resources :users, except: [:new]
  # post "/signup", to: "users#create"
  
  put "singers/:id/avatar", to:"singers#update_avatar"
  resources :singers
  post "/singer/signup", to:"singers#create"

  get "videos/singer", to:"videos#show_singer_videos"
  get "videos/trending", to:"videos#show_trending_videos"
  get "videos/singer/public", to:"videos#show_singer_public_videos"
  get "videos/public", to:"videos#show_public_videos"
  post "videos/:id/thumbnails", to:"videos#update_thumbnails"
  put "videos/:id/views", to:"videos#update_views"
  get "videos/category", to:"videos#show_videos_by_category"
  resources :videos

  get "feelings/like_videos", to:"feelings#get_liked_videos"
  post "feelings/check", to:"feelings#check_feelings"
  resources :feelings

  post "subscribes/check", to:"subscribes#check_subscribes"
  get "subscribes/channels", to:"subscribes#show_subscribes_channels"
  get "subscribes/videos", to:"subscribes#show_subscribes_videos"
  get "subscribes/subscribers", to:"subscribes#show_subscribers"
  resources :subscribes

  get "comments/videos", to:"comments#show_comments"
  resources :comments

  resources :histories

  get "search", to:"searchs#index"

  resources :categories, only: [:index]

  get "member_notifications/notifications", to:"member_notifications#show_recent_videos_notifications"
  resources :member_notifications, only: [:index, :update]
  get "playlist_videos/playlist_for_user", to:"playlist_videos#show_playlist_for_user"
  resources :playlist_videos
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

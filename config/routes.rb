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
  require "sidekiq/web"
    mount Sidekiq::Web => "/sidekiq"
  put "users/:id/avatar", to:"users#update_avatar"
  resources :users, except: [:new]
  # post "/signup", to: "users#create"
  get "singers/age_chart", to:"singers#show_age_data"
  get "singers/gender_chart", to:"singers#show_gender_data"
  get "singers/feeling_chart", to:"singers#show_feelings_data"
  get "singers/watched_hour_chart", to:"singers#show_watched_hour_data"
  get "singers/view_month_chart", to:"singers#show_monthly_view_analytics"
  get "singers/view_week_chart", to:"singers#show_weekly_view_analytics"
  put "singers/:id/avatar", to:"singers#update_avatar"
  resources :singers
  post "/singer/signup", to:"singers#create"

  get "videos/recommend_after_watching", to:"videos#show_recommend_after_watching"
  get "videos/recommend_for_playlist", to:"videos#show_recommend_for_playlist"
  get "videos/singer", to:"videos#show_singer_videos"
  get "videos/trending", to:"videos#show_trending_videos"
  get "videos/singer/public", to:"videos#show_singer_public_videos"
  get "videos/public", to:"videos#show_public_videos"
  post "videos/:id/thumbnails", to:"videos#update_thumbnails"
  put "videos/:id/views", to:"videos#update_views"
  get "videos/category", to:"videos#show_videos_by_category"
  get "videos/watched", to:"videos#show_watched_videos"
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
  get "comments/singer", to:"comments#show_comments_for_singer"
  resources :comments

  resources :histories

  get "search", to:"searchs#index"

  resources :categories, only: [:index]

  resources :hash_tags, only: [:index]

  get "member_notifications/notifications", to:"member_notifications#show_recent_videos_notifications"
  resources :member_notifications, only: [:index, :update]

  get "singer_notifications/notifications", to:"singer_notifications#show_recent_videos_notifications"
  resources :singer_notifications, only: [:index, :update]

  get "playlist_videos/playlist_for_user", to:"playlist_videos#show_playlist_for_user"
  resources :playlist_videos

  resources :replies
  resources :singer_replies

  post "watch_later_videos/check_watch_later", to:"watch_later_videos#check_watch_later"
  resources :watch_later_videos

  get "own_playlists/check_video", to:"own_playlists#check_video"
  post "own_playlist_videos/add_video", to:"own_playlist_videos#create"
  post "own_playlist_videos/remove_video", to:"own_playlist_videos#remove_video"
  resources :own_playlists
  resources :own_playlist_videos
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

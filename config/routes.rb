Rails.application.routes.draw do
  resources :users, except: [:new]
  post "/signup", to: "users#create"
  resources :singers
  post "/singer/signup", to:"singers#create"
  resources :videos
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

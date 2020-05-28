Rails.application.routes.draw do

  resources :users
  resources :posts  

  # いいね
  post "likes/:post_id", to: "likes#create", as: "like"
  delete "likes/:post_id", to: "likes#destroy", as: "unlike"
  
  # ログイン
  get "login",to: "users#login_page"
  post "login",to: "users#login"
  
  
  # ログアウト
  post "logout",to: "users#logout"
  
  # 検索ページ
  get "search_page", to: "posts#search_page"

  
  #TOPページ
  root to: "home#top"

  #ABOUTページ
  get "about", to: "home#about"
  

end

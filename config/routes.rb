# frozen_string_literal: true

Rails.application.routes.draw do
  post '/sign_up', action: :sign_up, controller: :users
  post '/login', action: :login, controller: :users

  post '/images', action: :create, controller: :images
  get '/images/:id', action: :query_image, controller: :images
  get '/user/:owner_id/images', action: :query_user_images, controller: :images
  get '/user/:owner_id/friends/images', action: :query_friends_images, controller: :images

  post '/relationship/create', action: :create, controller: :user_relationships
  delete '/relationship/delete', action: :delete, controller: :user_relationships

  post 'user/images/search', action: :search_user_images, controller: :search
  post '/user/friends/images/search', action: :search_friends_images, controller: :search
end

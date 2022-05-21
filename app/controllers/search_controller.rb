# frozen_string_literal: true

# Controller for search functions
class SearchController < ApplicationController
  def search_user_images
    image_ids = Image.where(owner_id: search_params[:owner_id])
    images = []
    image_ids.each do |image_id|
      images << image_id if image_id.name.downcase.include?(search_params[:search_term].downcase)
    end
    render json: { images: images }
  end

  def search_friends_images
    image_ids = friend_images
    images = []
    image_ids.each do |image_id|
      images << image_id.name.downcase.include?(search_params[:search_term].downcase) ? image_id : next
    end
    render json: { images: image_ids }
  end

  private

  def search_params
    params.require(:search).permit(:owner_id, :search_term)
  end

  def friend_images
    friends = UserRelationship.where(relating_user_id: search_params[:owner_id], relationship_type: 'friend')
    image_ids = []
    friends.each do |friend|
      image_ids << Image.where(owner_id: friend.related_user_id)
    end
    image_ids
  end
end

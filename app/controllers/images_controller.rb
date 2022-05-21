# frozen_string_literal: true

# Controller for images
class ImagesController < ApplicationController
  def query_user_images
    images = Image.where(owner_id: image_params[:owner_id])
    render json: images
  end

  def query_image
    image = Image.find(image_params[:id])
    render json: image
  end

  def query_friends_images
    image_ids = friend_images
    render json: { images: image_ids }
  end

  def create
    image = Image.create(image_params)
    render json: { status: image.valid? ? 'success' : image.errors }
  end

  private

  def image_params
    params.permit(:name, :description, :image_file, :owner_id, :id, :search_term)
  end

  def friend_images
    friends = UserRelationship.where(relating_user_id: image_params[:owner_id], relationship_type: 'friend')
    image_ids = []
    friends.each do |friend|
      image_ids << Image.where(owner_id: friend.related_user_id)
    end
    image_ids
  end
end

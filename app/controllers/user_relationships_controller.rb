# frozen_string_literal: true

# Controller for user relationships
class UserRelationshipsController < ApplicationController
  def create
    if user_relationship_params[:relating_user_id] == user_relationship_params[:related_user_id] || exists?
      render json: { status: 'error' }
    else
      handle_create
    end
  end

  def delete
    relationship = UserRelationship.find(user_relationship_params[:id]).destroy
    render json: { status: relationship.destroyed? ? 'success' : 'error' }
  end

  private

  def user_relationship_params
    params.require(:user_relationship).permit(:relating_user_id, :related_user_id, :relationship_type, :id)
  end

  def handle_create
    case user_relationship_params[:relationship_type]
    when 'friend'
      relationship = UserRelationship.find_by(
        relating_user_id: user_relationship_params[:related_user_id],
        related_user_id: user_relationship_params[:relating_user_id]
      )
      render json: { status: handle_friend_request(relationship) ? 'success' : 'error' }
    when 'block'
      handle_block
    end
  end

  def handle_friend_request(relationship)
    if !relationship.present?
      relationship = UserRelationship.create(user_relationship_params)
      relationship.update(relationship_type: 'request')
    elsif relationship.relationship_type == 'request'
      relationship.update(relationship_type: 'friend')
      UserRelationship.create(user_relationship_params)
    else
      return false
    end
    true
  end

  def handle_block
    UserRelationship.where(relating_user_id: user_relationship_params[:related_user_id],
                           related_user_id: user_relationship_params[:relating_user_id]).destroy_all
    UserRelationship.where(relating_user_id: user_relationship_params[:relating_user_id],
                           related_user_id: user_relationship_params[:related_user_id]).destroy_all
    UserRelationship.create(user_relationship_params)
    render json: { status: 'success', message: 'User blocked' }
  end

  def exists?
    UserRelationship.where(
      relating_user_id: user_relationship_params[:relating_user_id],
      related_user_id: user_relationship_params[:related_user_id],
      relationship_type: user_relationship_params[:relationship_type] == 'friend' ? 'friend' || 'request' : 'block'
    ).present?
  end
end

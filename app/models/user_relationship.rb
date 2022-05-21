# frozen_string_literal: true

class UserRelationship < ApplicationRecord
  belongs_to :related_user, class_name: 'User', foreign_key: 'related_user_id'
  belongs_to :relating_user, class_name: 'User', foreign_key: 'relating_user_id'
end

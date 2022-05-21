# frozen_string_literal: true

class Image < ApplicationRecord
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'
  has_one_attached :image_file, dependent: :destroy
end

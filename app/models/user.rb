# frozen_string_literal: true

class User < ApplicationRecord
  has_many :images
  has_many :user_relationships

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true
end

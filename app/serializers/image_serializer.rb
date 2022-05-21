# frozen_string_literal: true

# Serializer for image file
class ImageSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :name, :description, :image_file
  def image_file
    return unless object.image_file.attached?

    { url: rails_blob_url(object.image_file) }
  end
end

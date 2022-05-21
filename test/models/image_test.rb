# frozen_string_literal: true

require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  test 'invalid image' do
    image = Image.new(image_file: nil)
    assert_not image.valid?
  end
end

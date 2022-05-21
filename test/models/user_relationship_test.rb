# frozen_string_literal: true

require 'test_helper'

class UserRelationshipTest < ActiveSupport::TestCase
  test 'valid relationship' do
    user1 = User.create(username: 'username1', password: 'password')
    user2 = User.create(username: 'username2', password: 'password')
    relationship = UserRelationship.new(relating_user_id: user1.id, related_user_id: user2.id,
                                        relationship_type: 'block')
    assert relationship.valid?
  end
end

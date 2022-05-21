# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'valid user' do
    user = User.new(username: 'username', password: 'password')
    assert user.valid?
  end

  test 'invalid without username' do
    user = User.new(username: nil, password: 'password')
    assert_not user.valid?
  end

  test 'invalid without password' do
    user = User.new(username: 'username', password: nil)
    assert_not user.valid?
  end
end

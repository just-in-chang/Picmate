# frozen_string_literal: true

# Add user relationship reference
class AddUserRelationshipReference < ActiveRecord::Migration[6.1]
  def change
    add_reference :images, :owner, foreign_key: { to_table: :users }
    add_reference :user_relationships, :relating_user, foreign_key: { to_table: :users }
    add_reference :user_relationships, :related_use, foreign_key: { to_table: :users }
  end
end

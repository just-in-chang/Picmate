# frozen_string_literal: true

# Fix typo in column
class RenameRelationColumn < ActiveRecord::Migration[6.1]
  def change
    rename_column :user_relationships, :related_use_id, :related_user_id
    rename_column :user_relationships, :type, :relationship_type
  end
end

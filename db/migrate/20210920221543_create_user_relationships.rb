# frozen_string_literal: true

# Create user relationships model
class CreateUserRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :user_relationships do |t|
      t.string :type

      t.timestamps
    end
  end
end

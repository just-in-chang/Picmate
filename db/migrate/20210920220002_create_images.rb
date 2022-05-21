# frozen_string_literal: true

# Create images model
class CreateImages < ActiveRecord::Migration[6.1]
  def change
    create_table :images do |t|
      t.string :name
      t.string :description
      t.integer :upvotes

      t.timestamps
    end
  end
end

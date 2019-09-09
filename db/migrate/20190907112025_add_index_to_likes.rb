class AddIndexToLikes < ActiveRecord::Migration[6.0]
  def change
    add_index :likes, [:likeable_id, :likeable_type, :user_id], unique: true
  end
end

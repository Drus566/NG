class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true
  
      t.timestamps
    end
    add_index :posts, [:user_id, :created_at]
  end
end

# t.references :section, foreign_key: true
# add_index :posts, :section_id

class AddNewsToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :news, :boolean, :default => false
  end
end

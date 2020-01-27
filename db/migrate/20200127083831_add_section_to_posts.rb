class AddSectionToPosts < ActiveRecord::Migration[6.0]
  def change
    add_reference :posts, :section, foreign_key: true
  end
end

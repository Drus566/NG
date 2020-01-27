class CreateSections < ActiveRecord::Migration[6.0]
  def change
    create_table :sections do |t|
      t.string :name, null: false, limit: 30
      
      t.timestamps
    end
    add_index :sections, :name, unique: true
  end
end

class CreateCatalogs < ActiveRecord::Migration[6.0]
  def change
    create_table :catalogs do |t|
      t.string :name, null:false

      t.timestamps
    end
  end
end

class CreateCatalogItems < ActiveRecord::Migration[6.0]
  def change
    create_table :catalog_items do |t|
      t.string :name, null: false
      t.string :address
      t.string :phone
      t.string :shedule
      t.text :info

      t.timestamps
    end
  end
end

class CreateJoinTableCatalogCatalogItems < ActiveRecord::Migration[6.0]
  def change
    create_join_table :catalogs, :catalog_items do |t|
      t.index [:catalog_id, :catalog_item_id], :unique => true
    end
  end
end

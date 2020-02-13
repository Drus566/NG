class AddEmailSiteToCatalogItems < ActiveRecord::Migration[6.0]
  def change
    add_column :catalog_items, :email, :string
    add_column :catalog_items, :site, :string
  end
end

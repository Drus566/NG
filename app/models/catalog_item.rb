class CatalogItem < ApplicationRecord
    has_and_belongs_to_many :catalogs
end

class Catalog < ApplicationRecord
    has_and_belongs_to_many :catalog_items
end

class CatalogsController < ApplicationController

    def index
        @catalogs = Catalog.all
        @catalog_items = CatalogItem.all
    end

    def show 
        @catalog = Catalog.find(params[:id])
        @catalog_items = @catalog.catalog_items
        render partial: 'catalogs/content', object: @catalog_item, layout: false
    end
end

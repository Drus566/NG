class CatalogItemsController < ApplicationController

    def new 
        @catalog_item = CatalogItem.new
        render layout: false
    end

    def create
    end

    def edit
    end

    def update
    end

end

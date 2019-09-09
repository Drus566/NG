module TagsHelper
    def elimination_exist_elems(own, all)
        @result = Array.new
        all.each do |e|
            unless own.include?(e)
                @result<<(e)   
            end
        end
        @result 
    end

    def split_string(array)
        unless array.empty? 
            array = array.split(',')
        end
    end

    def add_tags(array, post)
        if @tags_ids = split_string(array)
            @tags = Tag.find(@tags_ids)
            @tags.each do |tag|
               post.tags << (tag)
            end
        end
    end

    def destroy_tags(array, post)
        if @tags_ids = split_string(array) 
            @tags = Tag.find(@tags_ids)
            @tags.each do |tag|
                post.tags.delete(tag)
            end
        end
    end
end

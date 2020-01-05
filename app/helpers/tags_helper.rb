module TagsHelper

    # сплитим строку
    def split_string(str)
        # если есть строка
        if str
            # если строка не пустая
            unless str.empty? 
                str = str.split(',')
            end
        end
    end
    
    # обновление постов тега
    def post_tags_update(new_tags, post)
        # находим старые теги поста
        @old_tags = post.tags
        # сплитим полученные с параметра айди тегов
        if @tags_new = split_string(new_tags)
            # смотрим, есть ли совпадающие старых айди тегов с новыми
            @old_tags.each do |tag|
                # если старый айди не совпадает с новым, то тег с этим айди удаляется
                unless @tags_new.include?(tag.id)
                    post.tags.delete(tag)
                else 
                    # если совпадает, то удаляется айди нового тега
                    @tags_new.delete(tag.id)
                end
            end
            post_tags_add(@tags_new, post)
        else
            post.tags.each do |tag|
                post.tags.delete(tag)
            end
        end
    end

    # добавление тегов
    def post_tags_add(tags, post)
        # если теги не массив 
        unless tags.kind_of?(Array)
            # то сплитим теги
            tags = split_string(tags)
        end
        # если теги есть 
        if tags
            @adding_tags = Tag.find(tags)
            # добавляем
            @adding_tags.each do |tag|
                post.tags << (tag)
            end
        end
    end
end

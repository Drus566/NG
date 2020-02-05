class Post < ApplicationRecord

    belongs_to :user
    belongs_to :section, optional: true
    
    has_many :comments, -> {order(created_at: :asc)}, as: :commentable, dependent: :destroy
    has_many :likes, -> {order(created_at: :asc)}, as: :likeable, dependent: :destroy

    has_rich_text :content

    default_scope -> { order(created_at: :desc) }

    validates :content, presence: true
    # validate :content_length
    validate :content_embeds
    
    validates :user_id, presence: true

    def get_like(current_user)
        self.likes.find_by(user_id: current_user)
    end

    def like?(current_user, vote)
        self.likes.find_by(user_id: current_user, vote: vote) != nil
    end

    def count_likes
        self.likes.where(vote: true).count - self.likes.where(vote: false).count
    end

    private 

        def content_embeds
            puts "#{rich_text_content.embeds.any?}"
            puts "#{rich_text_content.embeds.attached?}"
            puts "#{rich_text_content.embeds.blobs.any?}"
            puts "#{rich_text_content.embeds.attachments.any?}"
            puts "#{content.attachable_sgid}"
            errors.add(:content, 'ggwp')
           
            if content.embeds.attached?
                errors.add(:base, 'Нельзя загружать более 4 изображений') if content.embeds.attachments.size > 4
                content.embeds.blobs.each do |attach|
                    errors.add(:base, 'Размер') if attach.byte_size > 124
                    errors.add(:base, 'Можно загружать только изображения') unless attach.image? 
                    errors.add(:base, 'Недопустимый формат изображения') unless attach.content_type == 'image/jpeg' || attach.content_type == 'image/png'
                end
            end
        end 


        # def content_length 
        #     max_length = 50
        #     symbol_size = 0
        #     puts "#{content.embeds_blobs.empty?}"
        #     if content.embeds.attached? 
        #         content.embeds.each do |attach|
        #             symbol_size += (attach.filename.size + 2)
        #             puts "ATTACCCCCCCCCCCCCCCCCCCHHHHHHHHHHH  #{attach.filename.size}"
        #         end
        #     end
        #     puts "ALLLLLLLLLLLLLLLLLLLLO #{symbol_size}"
        #     puts "GGWEPPSDASPD #{content.to_plain_text.size}"
        #     puts "GGWEPPSDASPD #{content.to_s}"
        #     errors.add(:content, 'Слишком длинный текст') if (content.to_plain_text.size - symbol_size) > max_length
        #     puts "CONTENT BLOB #{content.embeds_blobs}"
        #     puts "CONTENT BLOB #{content.embeds}"
        # end
        # def content_embeds
        #     if content.embeds.attached?
        #         errors.add(:content, 'Нельзя загружать более 4 изображений') if content.embeds.size > 4
        #         content.embeds.each do |attach|
        #             errors.add(:content, 'Изображение не может весить > 10 мБ') if attach.byte_size > 1242880
        #             errors.add(:content, 'Можно загружать только изображения') unless attach.image? 
        #             errors.add(:content, 'Недопустимый формат изображения') unless attach.content_type == 'image/jpeg' || attach.content_type == 'image/png'
        #         end
        #     end
        # end 

        # def content_length 
        #     max_length = 50
        #     symbol_size = 0
        #     puts "#{content.embeds_blobs.empty?}"
        #     if content.embeds.attached? 
        #         content.embeds.each do |attach|
        #             symbol_size += (attach.filename.size + 2)
        #             puts "ATTACCCCCCCCCCCCCCCCCCCHHHHHHHHHHH  #{attach.filename.size}"
        #         end
        #     end
        #     puts "ALLLLLLLLLLLLLLLLLLLLO #{symbol_size}"
        #     puts "GGWEPPSDASPD #{content.to_plain_text.size}"
        #     puts "GGWEPPSDASPD #{content.to_s}"
        #     errors.add(:content, 'Слишком длинный текст') if (content.to_plain_text.size - symbol_size) > max_length
        #     puts "CONTENT BLOB #{content.embeds_blobs}"
        #     puts "CONTENT BLOB #{content.embeds}"
        # end


    # <div>
        #     <p>To plain text: <%= post.content.to_plain_text %></p>
        #     <p>To plain text size: <%= post.content.to_plain_text.size %></p>
        # </div>
        # <div class="post-content-wrapper"><%= run_rinku(post.content.to_s) %></div>
        # <div>
        #     <p>Embed any?: <%= post.content.embeds.any? %></p>
        #     <p>Embeds size: <%= post.content.embeds.size %></p>
        #     <p>Post content tos: <%= post.content.to_s %></p>
        #     <p>Post content tos size: <%= post.content.to_s.size %></p>
        #     <p>Post content methods: <%= post.content.methods %></p>
        #     <% post.content.embeds.each do |attach| %>
        #         <p>Bytesize: <%= attach.byte_size %></p>
        #         <p>Image?: <%= attach.image? %></p>
        #         <p>Content_type: <%= attach.content_type %></p>
        #         <p>Image name: <%= attach.filename %></p>
        #     <% end %>
        # </div>
end
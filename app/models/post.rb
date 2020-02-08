class Post < ApplicationRecord

    belongs_to :user
    belongs_to :section, optional: true
    
    has_many :comments, -> {order(created_at: :asc)}, as: :commentable, dependent: :destroy
    has_many :likes, -> {order(created_at: :asc)}, as: :likeable, dependent: :destroy

    has_rich_text :content

    default_scope -> { order(created_at: :desc) }

    validates :content, presence: true
    validate :content_length
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
            @max_byte_size = 10485760 # 10 mB
            @attachments = rich_text_content.body.attachments

            if @attachments.any?
                errors.add(:base, 'Нельзя загружать более 4 изображений') if @attachments.size > 4
                @attachments.each do |attach|
                    errors.add(:base, 'Размер') if attach.byte_size > @max_byte_size
                    errors.add(:base, 'Можно загружать только изображения') unless attach.image? 
                    errors.add(:base, 'Недопустимый формат изображения') unless attach.content_type == 'image/jpeg' || attach.content_type == 'image/png'
                end
            end
        end 

        def content_length 
            @max_length = 5
            @attachments = rich_text_content.body.attachments
            @total_size = rich_text_content.body.to_plain_text.length
            @unwanted = 0
            
            @unwanted = @attachments.inject(0) {|sum, elem| sum + (elem.filename.to_s.length + 2) } if @attachments.any? 
            errors.add(:base, 'Слишком много символов') if ((@total_size - @unwanted) > @max_length) 
        end
end
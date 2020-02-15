class User < ApplicationRecord
    has_secure_password

    has_one_attached :avatar

    has_many :posts
    has_many :comments, dependent: :destroy
    has_many :likes, dependent: :destroy
    has_many :messages, dependent: :destroy

    validates :name, presence: { message: 'Заполните имя' }
    validates :name, length: { in: 2..30, message: 'Длинна имени от 2 до 30 символов' }
    validates :email, presence: { message: "Заполните почту" }, 
                      length: { maximum: 50, message: 'Длинна почты максимум 30 символов' }, 
                      format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i, message: 'Неверная почта' }, 
                      uniqueness: { case_sensitive: false, message: 'Такая почта существует' }
    validates :password, presence: { message: 'Пароль не может быть пустым'}, length: { minimum: 6, message: 'Минимальная длинна пароля 6 символов' }
    validate :avatar_content_type
    validate :avatar_byte_size

    attr_accessor :remember_token

    def self.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
        # Создает хэш токена из строки токена с определенными затратми cost
        BCrypt::Password.create(string, cost: cost)
    end

    # Генерирует токен
    def self.new_token
        SecureRandom.urlsafe_base64
    end

    def remember
        self.remember_token = User.new_token
        # Создание хэша токена и запись этого хэша в БД
        update_attribute(:remember_digest, User.digest(remember_token))
    end

    def authenticated?(remember_token)
        # Возвращает фалс если нет записи хэша токена в БД
        return false if remember_digest.nil?
        # Сравнивает запись хэша токена в БД с входящим в функцию токеном
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end

    def forget
        # Стирает запись хэша токена из БД
        update_attribute(:remember_digest, nil)
    end

    private 
        
        def avatar_content_type 
            if user.avatar.attached? 
                errors.add(:user, 'Недопустимый формат изображения') unless user.avatar.content_type == 'image/jpeg' || attach.content_type == 'image/png'
            end
        end

        def avatar_byte_size
            @max_byte_size = 10485760 # 10 mB

            if user.avatar.attached? 
                errors.add(:user, 'Недопустимый вес файла') if user.avatar.byte_size > @max_byte_size
            end
        end
end

class User < ApplicationRecord
    has_secure_password

    has_many :posts, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :likes, dependent: :destroy

    validates :name, presence: true, length: {maximum: 30}
    validates :email, presence: true, length: { maximum: 50 }, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }, uniqueness: { case_sensitive: false }
    validates :password, presence: true, length: { minimum: 6 }

    attr_accessor :remember_token

    # def self.digest(string)
    #     cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    #     # Создает хэш токена из строки токена с определенными затратми cost
    #     BCrypt::Password.create(string, cost: cost)
    # end

    # # Генерирует токен
    # def self.new_token
    #     SecureRandom.urlsafe_base64
    # end

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
end

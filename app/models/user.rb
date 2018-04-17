class User < ApplicationRecord
    has_secure_password
    before_save { self.email = email.downcase }
    validates :name, presence: true, length: { maximum: 19 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 25 },
                                      format: { with: VALID_EMAIL_REGEX },
                                  uniqueness: { case_sensitive: false }
    validates :password, length: { minimum: 6 }
end

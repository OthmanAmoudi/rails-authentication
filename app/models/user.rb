# this mamge the users behaviours
class User < ApplicationRecord
  before_save { email.downcase! }
  attr_accessor :remember_token
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true,
                      length: { maximum: 54 },
                      format: { with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i },
                      uniqueness: { case_sensitive: false },
                      allow_blank: true
  has_secure_password
  validates :password, presence: true,
                         length: { minimum: 6 },
                      allow_nil: true
  has_many :posts, dependent: :destroy

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
end
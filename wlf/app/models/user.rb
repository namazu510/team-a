class User < ActiveRecord::Base

  has_many :weights
  has_many :exercise_logs

  before_save { self.email = email.downcase }
  has_secure_password
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_const ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end


  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }

  validates :gender,  :inclusion => {
    in: 0..1
  }

  validates :height,  :numericality => {
    :greater_than_or_equal_to => 0 ,
    :less_than => 300
  }

  validates :age,  :numericality => {
    :only_integer => true ,
    :greater_than_or_equal_to => 0 ,
    :less_than => 200
  }

end

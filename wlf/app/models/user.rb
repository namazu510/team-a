class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  has_secure_password
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_const ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  validates :gender,  :numericality => {
    :only_integer => true,
    :greater_than_or_equal_to => 0,
    :less_than => 2
  }

  validates :height,  :numericality => {
    :greater_than_or_equal_to => 0,
    :less_than => 300
  }

  validates :age,  :numericality => {
    :only_integer => true,
    :greater_than_or_equal_to => 0,
    :less_than => 200
  }
end

class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  has_secure_password
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_const ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end

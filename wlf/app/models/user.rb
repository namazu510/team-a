class User < ApplicationRecord

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }

  validates :gender,  :inclusion{
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

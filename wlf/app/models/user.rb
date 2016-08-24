class User < ApplicationRecord

  validates :gender,  :numericality => {
    :only_integer => true,
    :greater_than_or_equal_to => 0
    :less_than => 2
  }

  validates :height,  :numericality => {
    :greater_than_or_equal_to => 0
    :less_than => 300
  }

  validates :age,  :numericality => {
    :only_integer => true,
    :greater_than_or_equal_to => 0
    :less_than => 120
  }
end

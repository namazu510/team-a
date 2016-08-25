class Weight < ApplicationRecord
  belongs_to :user

  validates :weight , :numericality=>{
    :greater_than_or_equal_to => 0
    :less_than => 1000
  }

  validates :bmi , :numericality=>{
    :greater_than_or_equal_to => 0
    :less_than => 100
  }
end

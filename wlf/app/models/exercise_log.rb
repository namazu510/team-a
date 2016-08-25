class ExerciseLog < ApplicationRecord
  belongs_to :user
  
  validates :step_cnt ,:numericality =>{
    :only_integer => true ,
    :greater_than => 0 ,
    :less_than => 999999
  }

  validates :calorie ,:numericality =>{
    :greater_than => 0 ,
    :less_than => 999999
  }

end

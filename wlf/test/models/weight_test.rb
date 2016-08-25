require 'test_helper'

class WeightTest < ActiveSupport::TestCase
  def setup
    @user = users(:user1)
    @weight = @user.weight.build(weight: 70)
  end

  test "valid?" do
    assert @weight.valid?
  end
end

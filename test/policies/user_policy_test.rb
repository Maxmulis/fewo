require 'test_helper'

class UserPolicyTest < ActiveSupport::TestCase
  def setup
    @admin_user = users(:admin_user)
    @regular_user = users(:regular_user)
  end

  test 'only admin can invite users' do
    user = User.new
    assert UserPolicy.new(@admin_user, user).invite?
    assert_not UserPolicy.new(@regular_user, user).invite?
  end
end

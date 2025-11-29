require 'test_helper'

class CampPolicyTest < ActiveSupport::TestCase
  def setup
    @admin_user = users(:admin_user)
    @regular_user = users(:regular_user)
  end

  test 'anyone can view camps index' do
    assert CampPolicy.new(@admin_user, Camp).index?
    assert CampPolicy.new(@regular_user, Camp).index?
  end

  test 'anyone can view a camp' do
    camp = Camp.new
    assert CampPolicy.new(@admin_user, camp).show?
    assert CampPolicy.new(@regular_user, camp).show?
  end

  test 'only admin can create camp' do
    camp = Camp.new
    assert CampPolicy.new(@admin_user, camp).create?
    assert_not CampPolicy.new(@regular_user, camp).create?
  end

  test 'only admin can update camp' do
    camp = Camp.new
    assert CampPolicy.new(@admin_user, camp).update?
    assert_not CampPolicy.new(@regular_user, camp).update?
  end

  test 'only admin can destroy camp' do
    camp = Camp.new
    assert CampPolicy.new(@admin_user, camp).destroy?
    assert_not CampPolicy.new(@regular_user, camp).destroy?
  end
end

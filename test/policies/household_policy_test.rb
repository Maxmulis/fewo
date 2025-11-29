require 'test_helper'

class HouseholdPolicyTest < ActiveSupport::TestCase
  def setup
    @admin_user = users(:admin_user)
    @regular_user = users(:regular_user)
    @admin_household = households(:admin_household)
    @regular_household = households(:regular_household)
  end

  test 'admin can view any household' do
    assert HouseholdPolicy.new(@admin_user, @regular_household).show?
    assert HouseholdPolicy.new(@admin_user, @admin_household).show?
  end

  test 'regular user can view only their own household' do
    assert HouseholdPolicy.new(@regular_user, @regular_household).show?
    assert_not HouseholdPolicy.new(@regular_user, @admin_household).show?
  end

  test 'admin can create household' do
    household = Household.new
    assert HouseholdPolicy.new(@admin_user, household).create?
  end

  test 'regular user cannot create household' do
    household = Household.new
    assert_not HouseholdPolicy.new(@regular_user, household).create?
  end

  test 'admin can update any household' do
    assert HouseholdPolicy.new(@admin_user, @regular_household).update?
    assert HouseholdPolicy.new(@admin_user, @admin_household).update?
  end

  test 'regular user can update only their own household' do
    assert HouseholdPolicy.new(@regular_user, @regular_household).update?
    assert_not HouseholdPolicy.new(@regular_user, @admin_household).update?
  end

  test 'admin can destroy any household' do
    assert HouseholdPolicy.new(@admin_user, @regular_household).destroy?
  end

  test 'regular user cannot destroy any household' do
    assert_not HouseholdPolicy.new(@regular_user, @regular_household).destroy?
  end

  test 'admin can access index' do
    assert HouseholdPolicy.new(@admin_user, Household).index?
  end

  test 'regular user cannot access index' do
    assert_not HouseholdPolicy.new(@regular_user, Household).index?
  end
end

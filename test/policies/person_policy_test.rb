require 'test_helper'

class PersonPolicyTest < ActiveSupport::TestCase
  def setup
    @admin_user = users(:admin_user)
    @regular_user = users(:regular_user)
    @admin_person = people(:admin_person)
    @regular_person = people(:regular_person)
  end

  test 'admin can view any person' do
    assert PersonPolicy.new(@admin_user, @regular_person).show?
    assert PersonPolicy.new(@admin_user, @admin_person).show?
  end

  test 'regular user can view only their own person' do
    assert PersonPolicy.new(@regular_user, @regular_person).show?
    assert_not PersonPolicy.new(@regular_user, @admin_person).show?
  end

  test 'admin can create person' do
    person = Person.new
    assert PersonPolicy.new(@admin_user, person).create?
  end

  test 'regular user cannot create person' do
    person = Person.new
    assert_not PersonPolicy.new(@regular_user, person).create?
  end

  test 'admin can update any person' do
    assert PersonPolicy.new(@admin_user, @regular_person).update?
    assert PersonPolicy.new(@admin_user, @admin_person).update?
  end

  test 'regular user can update only their own person' do
    assert PersonPolicy.new(@regular_user, @regular_person).update?
    assert_not PersonPolicy.new(@regular_user, @admin_person).update?
  end

  test 'admin can destroy any person' do
    assert PersonPolicy.new(@admin_user, @regular_person).destroy?
  end

  test 'regular user cannot destroy any person' do
    assert_not PersonPolicy.new(@regular_user, @regular_person).destroy?
  end

  test 'anyone can access index' do
    assert PersonPolicy.new(@admin_user, Person).index?
    assert PersonPolicy.new(@regular_user, Person).index?
  end
end

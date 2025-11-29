require 'test_helper'

class RegistrationPolicyTest < ActiveSupport::TestCase
  def setup
    @admin_user = users(:admin_user)
    @regular_user = users(:regular_user)
    @admin_person = people(:admin_person)
    @regular_person = people(:regular_person)
  end

  test 'anyone can view registrations index' do
    assert RegistrationPolicy.new(@admin_user, Registration).index?
    assert RegistrationPolicy.new(@regular_user, Registration).index?
  end

  test 'anyone can view a registration' do
    registration = Registration.new
    assert RegistrationPolicy.new(@admin_user, registration).show?
    assert RegistrationPolicy.new(@regular_user, registration).show?
  end

  test 'admin can create any registration' do
    registration = Registration.new(person: @regular_person)
    assert RegistrationPolicy.new(@admin_user, registration).create?
  end

  test 'regular user can create registration for themselves' do
    registration = Registration.new(person: @regular_person)
    assert RegistrationPolicy.new(@regular_user, registration).create?
  end

  test 'regular user cannot create registration for others' do
    registration = Registration.new(person: @admin_person)
    assert_not RegistrationPolicy.new(@regular_user, registration).create?
  end

  test 'only admin can update registration' do
    registration = Registration.new
    assert RegistrationPolicy.new(@admin_user, registration).update?
    assert_not RegistrationPolicy.new(@regular_user, registration).update?
  end

  test 'only admin can destroy registration' do
    registration = Registration.new
    assert RegistrationPolicy.new(@admin_user, registration).destroy?
    assert_not RegistrationPolicy.new(@regular_user, registration).destroy?
  end
end

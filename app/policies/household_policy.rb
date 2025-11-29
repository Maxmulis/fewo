class HouseholdPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def show?
    user.admin? || record == user.person.household
  end

  def create?
    user.admin?
  end

  def update?
    user.admin? || user_in_household?
  end

  def destroy?
    user.admin?
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      elsif user.person.household
        scope.where(id: user.person.household.id)
      else
        scope.none
      end
    end
  end

  private

  def user_in_household?
    user.person.household == record
  end
end

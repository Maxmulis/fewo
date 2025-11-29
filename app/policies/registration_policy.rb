class RegistrationPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.admin? || record.person == user.person
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end

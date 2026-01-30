class RegistrationPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.admin? || user.team_member_for?(record.camp) || record.person == user.person
  end

  def update?
    user.admin? || user.team_member_for?(record.camp)
  end

  def destroy?
    user.admin? || user.team_member_for?(record.camp)
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end

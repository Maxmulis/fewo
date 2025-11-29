class PersonPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    user.admin? || record == user.person
  end

  def create?
    user.admin?
  end

  def update?
    user.admin? || record == user.person
  end

  def destroy?
    user.admin?
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(id: user.person.id)
      end
    end
  end
end

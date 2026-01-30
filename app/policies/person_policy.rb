class PersonPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    user.admin? || record == user.person || user_can_view_through_camp?(record)
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
      elsif user.team_member?
        camp_ids = user.team_camps.pluck(:id)
        person_ids = Registration.where(camp_id: camp_ids).pluck(:person_id).uniq
        scope.where(id: person_ids + [user.person.id])
      else
        scope.where(id: user.person.id)
      end
    end
  end

  private

  def user_can_view_through_camp?(person)
    return false unless user.team_member?
    camp_ids = user.team_camps.pluck(:id)
    Registration.where(person: person, camp_id: camp_ids).exists?
  end
end

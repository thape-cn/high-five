class ContractBasicPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.none
      end
    end
  end

  def new?
    user.admin?
  end

  def create?
    new?
  end

  def show?
    user.admin?
  end

  def invoke_ai?
    user.admin?
  end

  def destroy?
    user.admin?
  end

  def confirm_destroy?
    user.admin?
  end
end

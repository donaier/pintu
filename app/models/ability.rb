class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, User, id: user.id
    can :update, User, id: user.id

    if user.has_role? :admin
      can :manage, User
    end

    if user.has_role? :user_manager
      can :manage, User
    end
  end
end

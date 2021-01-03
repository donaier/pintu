class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    # authorised on own profile
    can :my_show, User
    can :my_edit, User
    can :update, User, id: user.id
    can :enable, User, id: user.id
    can :messages, User, id: user.id

    if user.has_role? :admin
      can :manage, User
      can :create, Mailboxer
    end

    if user.has_role? :user_manager
      can :manage, User
    end
  end
end

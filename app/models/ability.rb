class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, User
    else
      can :manage, User, id: user.id
    end

    if user.admin?
    	can :manage, Comment
    else
      can :manage, Comment
    	cannot :destroy, Comment 
    end

  end
end

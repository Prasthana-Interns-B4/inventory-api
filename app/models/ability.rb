class Ability
  include CanCan::Ability

  def initialize(user)
    if user&.facility_manager?
      can :manage, Device
      can :index, User
      can [:show, :update, :reset_password], User,id: user.id
    elsif user&.hr_manager?
      can :show, Device, user: user
			can :read, User, status: user.status
      can [:create, :update, :approve, :pending], User
      can :destroy, User ,id: ( User.ids - [2,66])
			can :reset_password, User, id: user.id
    elsif user&.present?
      can :show, Device, user: user
      can [:show, :update, :reset_password], User,id: user.id
    end
  end
end

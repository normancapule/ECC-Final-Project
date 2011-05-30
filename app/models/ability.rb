class Ability < ApplicationController
  include CanCan::Ability
  
  def initialize(user, session)
    user ||= User.new
    
    if user.role? :admin
      can :manage, :all
    elsif user.role? :user
      can :create, Comment
      can :create, Rating
      can :read, Story
      can :read, Project
      can :read, Tag
      can :read, Release
      if user.check_role?(:owner, session) || 
         user.check_role?(:manager, session)
        can :manage, Release
        can :manage, Story
      end
    end
  end
end

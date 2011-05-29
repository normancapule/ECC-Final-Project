class Ability < ApplicationController
  include CanCan::Ability
  
  def initialize(user, session)
    user ||= User.new
    
    if user.role?(:admin)
      can :manage, :all
    elsif user.role? :user
      if user.check_role?(:projectowner, session) || 
         user.check_role?(:projectmanager, session) ||
         user.check_role?(:creator, session) 
        can :manage, Release
        can :manage, Story
      end
      can :create, Comment
      can :create, Rating
      can :read, Story
      can :read, Project
      can :read, Tag
      can :read, Release
    end
  end
end

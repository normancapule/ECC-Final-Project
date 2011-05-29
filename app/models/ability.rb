class Ability < ApplicationController
  include CanCan::Ability
  
  def initialize(user)
    user ||= User.new # guest user
    
    if user.role? :admin
      can :manage, :all
    elsif user.role? :user
      can :create, Comment
      can :read, Story
      can :read, Project
      can :read, Tag
      can :read, Release
      can :create, Rating
    end
  end
end

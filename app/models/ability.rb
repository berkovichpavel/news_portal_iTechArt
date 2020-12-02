# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      if user.admin?
        can :manage, :all
      elsif user.correspondent?
        can :create, Item
        can :read, Item
        can :update, Item, user_id: user.id

        can :change_item, Item

        can :change_status, Item, user_id: user.id, status: [:revision]

        can :read_revision, Item, status: ['revision'], user_id: user.id
        can :read_verification, Item, status: ['check'], user_id: user.id
        can :read, Comment

      elsif user.redactor?
        can :update, Item, status: %w[check approved]
        can :read, Item

        can :read_verification, Item, status: ['check']
        can :approve, Item
        can :change_status, Item, status: %w[check approved archive]
        can :check_archive, Item
        can :read, Comment
      end
      can :read_annotation, Item
      can :read_full_text, Item
      can :read, User, id: user.id
      can :update, User, id: user.id
      can :read, Item, status: ['active']
      can :comment_item, Item #can :create, Comment
      can :read, Comment, user_id: User.where(role: 'user').ids
    else
      can :read, Item, status: ['active'], mask: %w[visible title_annotation only_header]
      can :read_annotation, Item, mask: %w[visible title_annotation]
      can :read_full_text, Item, mask: %w[visible]
    end



    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end

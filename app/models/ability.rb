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

      elsif user.redactor?
        can :update, Item, status: ['check']
        can :read, Item

        can :read_verification, Item, status: ['check']
        # can :read, Item, status: ['check', 'revision'], user_id: user.id
        can :approve, Item
        can :change_status, Item, status: ['check']
      end
      can :read_annotation, Item
      can :read, User, id: user.id
      can :update, User, id: user.id
      can :read, Item, status: ['approved']
    else
      can :read, Item, status: ['approved']
      can :read, Item, mask: ['visible to everyone', 'title and annotation are visible', 'only visible header']
      can :read_annotation, Item, mask: ['visible to everyone', 'title and annotation are visible']
      can :read_full_text, Item, mask: ['visible to everyone']
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

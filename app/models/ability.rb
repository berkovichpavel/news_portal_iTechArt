# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      can :track, Item
      if user.admin?
        can :manage, :all
      elsif user.correspondent?
        can :create, Item
        can :read, Item
        can :update, Item, author_id: user.id, status: [:revision, :check]
        can :change_item, Item
        can :change_status, Item, author_id: user.id, status: [:revision]
        can :read_revision, Item, status: 'revision', author_id: user.id
        can :read_verification, Item, status: 'check', author_id: user.id
        can :read, Comment
      elsif user.redactor?
        can :update, Item, status: %w[check active archive]
        can :read, Item
        can :read_verification, Item, status: ['check']
        can :approve, Item
        can :change_status, Item, status: %w[check active archive]
        can :check_archive, Item
        can :read, Comment
      end
      can :read_annotation, Item
      can :read_full_text, Item
      can :read, Item, status: ['active']
      can :comment_item, Item

      can :read, User
      can :view_full_profile, User
      can :update, User, id: user.id
      can :comments_activity, User, role: 'user'
      can :comments_activity, User, role: %w[correspondent admin redactor] if user.role.in?(%w[correspondent admin redactor])
      can :items_activity, User, hidden: false
      can :items_activity, User, hidden: true, id: user.id
      can :read, Comment, user_id: User.where(role: 'user').ids
      can :add_subscription, User, id: user.id
    else
      can :read, Item, status: ['active'], mask: %w[visible title_annotation only_header]
      can :read_annotation, Item, mask: %w[visible title_annotation]
      can :read_full_text, Item, mask: %w[visible]
      can :read, User
      can :track, Item
    end

  end

end

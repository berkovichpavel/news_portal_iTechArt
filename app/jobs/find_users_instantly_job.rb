class FindUsersInstantlyJob < ApplicationJob
  queue_as :default

  def perform(id)
    item = Item.where(id: id).first
    return unless item.status == 'active'

    users = User.joins(:subscription).where(signed: true, subscriptions: { sending_frequency: 'instantly' })
    users.each do |user|
      if user.subscription.categories.include?(item.category) || user.subscription.regions.include?(item.region) || (user.subscription.tags & item.tags).count.positive?
        NewUserEmailMailer.send_items_to_user(user.email, [item]).deliver_now
      end
    end
  end
end

class FindItemsForUsersJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    subscription = Subscription.where(user_id: user_id).first
    last_sent = subscription.last_sent
    items = Item.where(status: 'active', updated_at: last_sent..Time.current, category: subscription.categories)
                .or(Item.where(status: 'active', updated_at: last_sent..Time.current, tags: subscription.tags))
                .or(Item.where(status: 'active', updated_at: last_sent..Time.current, region: subscription.regions))
    items_id = items.map(&:id)
    subscription.last_sent = Time.current
    subscription.save
    return if items_id.empty?

    SendItemsToUserJob.perform_now(user_id, items_id)
  end
end

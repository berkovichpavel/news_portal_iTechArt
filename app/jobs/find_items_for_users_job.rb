class FindItemsForUsersJob < ApplicationJob
  queue_as :default


  def perform(user_id)
    subscription = Subscription.where(user_id: user_id).first
    last_sent = subscription.last_sent
    items = Item.where(status: 'active', updated_at: last_sent..Time.current)
    items_id = items.map(&:id)
    subscription.last_sent = Time.current
    subscription.save
    SendItemsToUserJob.perform_now(user_id, items_id)
  end
end

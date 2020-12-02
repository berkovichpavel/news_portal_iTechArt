class FindItemsForUsersJob < ApplicationJob
  queue_as :default


  def perform(user_id)
    subscription = Subscription.where(user_id: user_id).first
    last_sent = subscription.last_sent
    subscription.last_sent = Time.current
    items = Item.where(status: 'approved', updated_at: last_sent..Time.current)
    items_id = items.map(&:id)
    SendItemsToUserJob.perform_now(user_id, items_id)
  end
end

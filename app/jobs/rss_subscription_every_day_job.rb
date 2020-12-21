class RssSubscriptionEveryDayJob < ApplicationJob
  queue_as :default

  def perform
    subscriptions = RssSubscription.all
    subscriptions.each do |subscription|
      CreateRssNewsJob.perform_later(subscription.reference_link, subscription.category)
    end
  end
end

class FindAllUsersJob < ApplicationJob
  queue_as :default
  SENDING = { 'once_a_day' => 1.day.ago, 'every_two_days' => 2.day.ago,
              'once_a_week' => 1.week.ago, 'instantly' => Time.current }.freeze

  def perform(*_args)
    users = User.joins(:subscription).where(signed: true, subscriptions: { dispatch_hour: Time.now.strftime('%H') })
    users.each do |user|
      FindItemsForUsersJob.perform_now(user.id) if user.subscription.last_sent < SENDING[user.subscription.sending_frequency]
    end
  end
end

class FindAllUsersJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    Rails.logger.info('done')
    users = User.joins(:subscription).where(signed: true, subscriptions: { dispatch_hour: Time.now.strftime('%H') })
    users_id = users.map(&:id)
    users_id.each do |user_id|
      FindItemsForUsersJob.perform_now(user_id)
    end
  end
end

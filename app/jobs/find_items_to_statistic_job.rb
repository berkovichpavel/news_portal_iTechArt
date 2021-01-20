class FindItemsToStatisticJob < ApplicationJob
  queue_as :default

  def perform(admin_id, statistic_id)
    admin = User.where(id: admin_id).first
    statistic = Statistic.where(id: statistic_id).first
    begin_time = statistic.begin_statistic
    end_time = statistic.end_statistic
    items = Item.where(created_at: begin_time..end_time)
    NewUserEmailMailer.send_items_statistic_to_admin(admin.email, items).deliver_now
  end
end

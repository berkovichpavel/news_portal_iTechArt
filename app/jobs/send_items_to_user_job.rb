class SendItemsToUserJob < ApplicationJob
  queue_as :default

  def perform(user_id, items_id)
    email = User.find(user_id).email
    items = Item.where(id: items_id)
    NewUserEmailMailer.send_items_to_user(email, items).deliver_now
  end
end

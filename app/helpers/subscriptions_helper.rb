module SubscriptionsHelper
  def subscription_form_header(subscription)
    method = subscription.new_record? ? 'Create new' : 'Edit'
    "#{method} subscription:"
  end
end

class InsertItemViewsJob < ApplicationJob
  queue_as :default

  def perform(user_id, item_id, request_env_hua, ip)
    ip_obj = IPAddr.new(ip)
    country = Geocoder.search(ip_obj).first.country if Geocoder.search(ip_obj).first
    browser = UserAgent.parse(request_env_hua).browser
    item = Item.find(item_id)
    if user_id
      item.item_views.push(ItemView.new(user_id: user_id, registered: true, user_ip: ip_obj, browser: browser, country: country)) unless item.item_views.where(user_id: user_id).exists?
    else
      item.item_views.push(ItemView.new(user_ip: ip_obj, browser: browser, country: country)) unless item.item_views.where(user_ip: ip_obj).exists?
    end
  end
end

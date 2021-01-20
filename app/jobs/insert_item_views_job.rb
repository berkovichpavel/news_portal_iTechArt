class InsertItemViewsJob < ApplicationJob
  queue_as :default

  def perform(user_id, item_id, request_env_agent, ip)
    country = JSON.parse(Net::HTTP.get(URI.parse("https://www.iplocate.io/api/lookup/#{ip}")))['country']
    browser = UserAgent.parse(request_env_agent).browser
    item = Item.find(item_id)
    if user_id
      item.item_views.push(ItemView.new(user_id: user_id, registered: true, user_ip: ip, browser: browser, country: country)) unless item.item_views.where(user_id: user_id).exists?
    else
      item.item_views.push(ItemView.new(user_ip: ip, browser: browser, country: country)) unless item.item_views.where(user_ip: ip).exists?
    end
  end
end

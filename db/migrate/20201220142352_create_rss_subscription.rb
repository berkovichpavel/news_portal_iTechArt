class CreateRssSubscription < ActiveRecord::Migration[6.0]
  def change
    create_table :rss_subscriptions do |t|
      t.string :reference_link, null: false
      t.string :category, default: 'news', null: false
      t.timestamps
    end
  end
end

class AddColumnsToSubscription < ActiveRecord::Migration[6.0]
  def change
    add_column :subscriptions, :tags, :string, array: true, default: []
    add_column :subscriptions, :regions, :string, array: true, default: []
    add_column :subscriptions, :categories, :string, array: true, default: []
  end
end

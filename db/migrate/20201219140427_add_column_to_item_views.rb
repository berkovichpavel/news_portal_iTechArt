class AddColumnToItemViews < ActiveRecord::Migration[6.0]
  def change
    add_column :item_views, :browser, :string
    add_column :item_views, :country, :string
    add_column :item_views, :watching_time, :integer
  end
end

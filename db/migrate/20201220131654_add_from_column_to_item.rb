class AddFromColumnToItem < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :reference_link, :string
    add_column :items, :rss, :boolean, default: false
  end
end

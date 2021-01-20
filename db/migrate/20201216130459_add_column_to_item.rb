class AddColumnToItem < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :published_at, :datetime
  end
end

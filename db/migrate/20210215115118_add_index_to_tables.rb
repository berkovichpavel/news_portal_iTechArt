class AddIndexToTables < ActiveRecord::Migration[6.0]
  def change
    add_index(:items, :title)
    add_index(:items, :short_description)

  end
end

class AddColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :signed, :boolean, default: false
  end
end

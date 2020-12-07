class AddHiddenColumnToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :hidden, :boolean, default: 'false'
  end
end

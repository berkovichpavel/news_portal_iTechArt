class AddAproveColumnToItem < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :status, :string, default: 'check'
  end
end

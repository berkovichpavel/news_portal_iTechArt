class AddColunmToComments < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :service_type, :string, default: 'default'
  end
end

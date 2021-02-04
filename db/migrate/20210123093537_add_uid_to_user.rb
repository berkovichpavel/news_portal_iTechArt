class AddUidToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :uid, :string

    add_column :users, :provider, :string
    add_column :users, :remember_token, :string
  end
end

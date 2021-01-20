class AddSharedLinksToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :user_site, :string, default: 'https://bootdey.com'
    add_column :users, :github, :string, default: 'https://bootdey.com'
    add_column :users, :instagram, :string, default: 'https://bootdey.com'
  end
end

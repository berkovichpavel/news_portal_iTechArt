class AddUserAndItemIdToReview < ActiveRecord::Migration[6.0]
  def change
    add_column :reviews, :user_id, :integer
    add_column :reviews, :item_id, :integer
  end
end

class CreateItemViews < ActiveRecord::Migration[6.0]
  def change
    create_table :item_views do |t|
      t.integer :user_id
      t.integer :item_id, null: false
      t.inet :user_ip
      t.boolean :registered, default: false

      t.timestamps
    end
  end
end

class CreateSubscriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :subscriptions do |t|
      t.datetime :last_sent
      t.integer :dispatch_hour
      t.string :sending_frequency
      t.integer :user_id

      # tags, regions, category ???

      t.timestamps
    end
  end
end

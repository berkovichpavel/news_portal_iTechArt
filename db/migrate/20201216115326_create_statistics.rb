class CreateStatistics < ActiveRecord::Migration[6.0]
  def change
    create_table :statistics do |t|
      t.datetime :begin_statistic
      t.datetime :end_statistic

      t.timestamps
    end
  end
end

class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :title, null: false
      t.string :short_description, null: false
      t.text :full_text
      t.string :category, null: false
      t.string :mask
      t.string :region
      t.datetime :last_editing # delete
      t.integer :status
      t.boolean :flag, default: false
      t.float :rating, default: 0
      t.string :redactor
      t.float :average_rating, default: 0

      t.timestamps
    end
  end
end

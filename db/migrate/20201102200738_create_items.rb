class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :title, null: false
      t.string :short_description, null: false
      t.text :full_text, null: false
      t.integer :category, null: false
      t.integer :mask, null: false
      t.string :main_img_href
      t.string :region
      t.datetime :last_editing
      t.integer :status
      t.boolean :flag, null: false, default: false
      t.float :rating, null: false, default: 0
      t.string :redactor, null: false
      t.float :average_rating, null: false, default: 0

      t.timestamps
    end
  end
end

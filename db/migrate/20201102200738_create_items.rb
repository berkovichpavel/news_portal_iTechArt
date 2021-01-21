class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :title, null: false
      t.string :short_description, null: false
      t.text :full_text
      t.string :category, default: 'news', null: false
      t.string :mask, default: 'visible', null: false
      t.string :region
      t.boolean :flag, default: false

      t.timestamps
    end
  end
end

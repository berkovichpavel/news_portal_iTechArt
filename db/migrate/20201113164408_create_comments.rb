class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.text :body
      t.references :item, null: false, foreign_key: true, on_delete: :cascade
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end

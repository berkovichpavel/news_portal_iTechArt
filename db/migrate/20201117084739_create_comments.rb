class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :commentable, polymorfic: true, null: false, foreign_key: true
      t.integer :parent_id
      t.text :body

      t.timestamps
    end
  end
end

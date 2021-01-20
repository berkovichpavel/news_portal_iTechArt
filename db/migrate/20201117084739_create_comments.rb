class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.references :user, foreign_key: true
      t.bigint :commentable_id
      t.string :commentable_type
      # t.references :commentable, polymorfic: true
      t.integer :parent_id
      t.text :body

      t.timestamps
    end
    add_index :comments, [:commentable_id, :commentable_type]
  end
end

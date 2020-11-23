class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      # t.string :commenter # references
      # t.text :body

      t.integer :parent_id
      t.text :body

      t.references :item, null: false, foreign_key: true
      t.references :user, foreign_key: true
      t.references :commentable, polymorphic: true


      t.timestamps
    end
  end
end

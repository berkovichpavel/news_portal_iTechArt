class AuthorOptional < ActiveRecord::Migration[6.0]
  def change
    change_column_null :items, :author_id, true
  end
end

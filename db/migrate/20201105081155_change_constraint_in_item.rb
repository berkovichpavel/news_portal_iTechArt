class ChangeConstraintInItem < ActiveRecord::Migration[6.0]
  def change
    change_column_null :items, :title, false
    change_column_null :items, :full_text, true
    change_column_null :items, :mask, true
    change_column_null :items, :flag, true
    change_column_null :items, :rating, true
    change_column_null :items, :redactor, true
    change_column_null :items, :average_rating, true
  end
end

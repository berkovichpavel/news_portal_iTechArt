class AddImageColumnToItem < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :main_img, :string
  end
end

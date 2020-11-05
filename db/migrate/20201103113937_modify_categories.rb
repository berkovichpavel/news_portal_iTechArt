class ModifyCategories < ActiveRecord::Migration[6.0]
  def change
    add_index :categories, :alias, unique: true
    Category.create alias: 'news', title: 'News'
    Category.create alias: 'finance', title: 'Finance'
    Category.create alias: 'sport', title: 'Sport'
    Category.create alias: 'health', title: 'Health'
    Category.create alias: 'realty', title: 'Realty'
    Category.create alias: 'auto', title: 'Auto'
  end
end

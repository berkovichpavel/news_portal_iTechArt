class AddRedactorAndCorrespondentToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :redactor, :boolean, default: false
    add_column :users, :correspondent, :boolean, default: false
  end
end

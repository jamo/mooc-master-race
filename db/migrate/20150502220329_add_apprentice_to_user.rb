class AddApprenticeToUser < ActiveRecord::Migration
  def change
    add_column :users, :apprentice, :boolean, default: false
  end
end

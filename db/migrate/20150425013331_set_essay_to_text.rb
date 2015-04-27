class SetEssayToText < ActiveRecord::Migration
  def up
    change_column :applicants, :essay, :text
  end

  def down
    change_column :applicants, :essay, :string
  end
end

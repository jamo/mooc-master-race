class AddMissingWeeks < ActiveRecord::Migration
  def change
    change_table :applicants do |t|
      t.decimal :week13, precision: 5, scale: 0
      t.decimal :week14, precision: 5, scale: 0
    end
  end
end

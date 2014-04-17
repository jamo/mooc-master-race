class AddWeekPercentageToUser < ActiveRecord::Migration
  def change
    change_table :applicants do |t|
      t.decimal :week1, precision: 5, scale: 2
      t.decimal :week2, precision: 5, scale: 2
      t.decimal :week3, precision: 5, scale: 2
      t.decimal :week4, precision: 5, scale: 2
      t.decimal :week5, precision: 5, scale: 2
      t.decimal :week6, precision: 5, scale: 2
      t.decimal :week7, precision: 5, scale: 2
      t.decimal :week8, precision: 5, scale: 2
      t.decimal :week9, precision: 5, scale: 2
      t.decimal :week10, precision: 5, scale: 0
      t.decimal :week11, precision: 5, scale: 0
      t.decimal :week12, precision: 5, scale: 0
    end
  end
end

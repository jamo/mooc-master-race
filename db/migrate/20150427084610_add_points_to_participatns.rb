class AddPointsToParticipatns < ActiveRecord::Migration
  def change
    change_table :applicants do |t|
      t.text :points_week1
      t.text :points_week2
      t.text :points_week3
      t.text :points_week4
      t.text :points_week5
      t.text :points_week6
      t.text :points_week7
      t.text :points_week8
      t.text :points_week9
      t.text :points_week10
      t.text :points_week11
      t.text :points_week12
      t.text :points_week13
      t.text :points_week14
    end
  end
end

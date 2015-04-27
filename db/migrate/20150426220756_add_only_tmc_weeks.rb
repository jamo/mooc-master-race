class AddOnlyTmcWeeks < ActiveRecord::Migration
  def change
    change_table :applicants do |t|
      t.decimal :only_tmc_week1, precision: 5, scale: 0
      t.decimal :only_tmc_week2, precision: 5, scale: 0
      t.decimal :only_tmc_week3, precision: 5, scale: 0
      t.decimal :only_tmc_week4, precision: 5, scale: 0
      t.decimal :only_tmc_week5, precision: 5, scale: 0
      t.decimal :only_tmc_week6, precision: 5, scale: 0
      t.decimal :only_tmc_week7, precision: 5, scale: 0
      t.decimal :only_tmc_week8, precision: 5, scale: 0
      t.decimal :only_tmc_week9, precision: 5, scale: 0
      t.decimal :only_tmc_week10, precision: 5, scale: 0
      t.decimal :only_tmc_week11, precision: 5, scale: 0
      t.decimal :only_tmc_week12, precision: 5, scale: 0
      t.decimal :only_tmc_week13, precision: 5, scale: 0
      t.decimal :only_tmc_week14, precision: 5, scale: 0
    end
  end
end

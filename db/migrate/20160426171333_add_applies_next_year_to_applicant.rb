class AddAppliesNextYearToApplicant < ActiveRecord::Migration
  def change
    add_column :applicants, :applies_next_year, :boolean
  end
end

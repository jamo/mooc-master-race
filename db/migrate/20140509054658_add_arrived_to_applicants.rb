class AddArrivedToApplicants < ActiveRecord::Migration
  def change
    add_column :applicants, :arrived, :boolean
    add_column :applicants, :arrival_time, :datetime
  end
end

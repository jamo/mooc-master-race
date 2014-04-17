class AddMissingPointsToApplicant < ActiveRecord::Migration
  def change
    add_column :applicants, :missing_points, :string, default: ""
  end
end

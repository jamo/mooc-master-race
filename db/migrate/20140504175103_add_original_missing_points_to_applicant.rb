class AddOriginalMissingPointsToApplicant < ActiveRecord::Migration
  def change
    add_column :applicants, :original_missing_points, :string
  end
end

class AddReadyForInterviewToApplicant < ActiveRecord::Migration
  def change
    add_column :applicants, :ready_for_interview, :boolean, default: false
  end
end

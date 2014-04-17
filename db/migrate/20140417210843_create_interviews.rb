class CreateInterviews < ActiveRecord::Migration
  def change
    create_table :interviews do |t|
      t.references :applicant
      t.references :interview_day

      t.datetime :start_time
      t.integer :duration_in_minutes

      t.timestamps
    end
  end
end

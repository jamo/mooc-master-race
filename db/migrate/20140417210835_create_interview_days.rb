class CreateInterviewDays < ActiveRecord::Migration
  def change
    create_table :interview_days do |t|
      t.datetime :date

      t.timestamps
    end
  end
end

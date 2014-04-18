class AddInterviewIdToApplicant < ActiveRecord::Migration
  def change
    add_reference :applicants, :interview, index: true
  end
end

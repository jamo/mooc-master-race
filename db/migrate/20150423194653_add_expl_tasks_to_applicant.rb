class AddExplTasksToApplicant < ActiveRecord::Migration
  def change
    change_table :applicants do |t|
      t.text :explanations, array: true, default: []
    end
  end
end

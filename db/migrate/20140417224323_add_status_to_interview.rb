class AddStatusToInterview < ActiveRecord::Migration
  def change
    add_column :interviews, :status, :integer, default: 0
  end
end

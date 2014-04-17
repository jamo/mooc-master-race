class AddKeyToApplicants < ActiveRecord::Migration
  def change
    add_column :applicants, :key, :string
  end
end

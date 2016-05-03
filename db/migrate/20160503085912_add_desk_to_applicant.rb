class AddDeskToApplicant < ActiveRecord::Migration
  def change
    add_column :applicants, :desk, :string
  end
end

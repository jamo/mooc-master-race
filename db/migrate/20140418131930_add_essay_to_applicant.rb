class AddEssayToApplicant < ActiveRecord::Migration
  def change
    add_column :applicants, :essay, :string
  end
end

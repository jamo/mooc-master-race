class AddPhoneToApplicant < ActiveRecord::Migration
  def change
    add_column :applicants, :phone_number, :string
  end
end

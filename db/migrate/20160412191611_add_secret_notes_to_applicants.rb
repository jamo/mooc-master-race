class AddSecretNotesToApplicants < ActiveRecord::Migration
  def change
    add_column :applicants, :secret_notes, :text
  end
end

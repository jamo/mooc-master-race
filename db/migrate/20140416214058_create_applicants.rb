class CreateApplicants < ActiveRecord::Migration
  def change
    create_table :applicants do |t|
      t.string :name
      t.string :nick
      t.string :email

      t.timestamps
    end
  end
end

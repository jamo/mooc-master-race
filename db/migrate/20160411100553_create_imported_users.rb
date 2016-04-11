class CreateImportedUsers < ActiveRecord::Migration
  def change
    create_table :imported_users do |t|
      t.string :last_name
      t.string :preferred_name
      t.string :email
      t.string :phone
      t.boolean :mooc
      t.boolean :eligible

      t.string :key # for auth and stuff

      t.references :applicant

      t.timestamps
    end
  end
end

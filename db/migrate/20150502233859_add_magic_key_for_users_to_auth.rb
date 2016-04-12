class AddMagicKeyForUsersToAuth < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'
    add_column :users, :key, :uuid, :default => 'uuid_generate_v1()'
  end
end

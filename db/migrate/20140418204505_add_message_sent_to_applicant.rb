class AddMessageSentToApplicant < ActiveRecord::Migration
  def change
    add_column :applicants, :message_sent, :boolean, default: false
  end
end

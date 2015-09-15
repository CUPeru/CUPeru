class AddSidAndStatusToMessages < ActiveRecord::Migration
  def change
    change_table :messages do |t|
      t.string :status
      t.string :twilio_sid
    end
  end
end

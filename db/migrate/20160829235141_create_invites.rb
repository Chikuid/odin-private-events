class CreateInvites < ActiveRecord::Migration[5.0]
  def change
    create_table :invites do |t|
      t.integer :attended_event_id
      t.integer :attendee_id

      t.timestamps
    end
    add_index :invites, :attendee_id
    add_index :invites, :attended_event_id
    add_index :invites, [:attendee_id, :attended_event_id], unique: true
  end
end

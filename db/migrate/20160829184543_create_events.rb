class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|

      t.string :location
      t.string :description

      t.timestamps
    end
    add_column :events, :creator_id, :integer
    add_index :events, [:creator_id, :created_at]
  end
end

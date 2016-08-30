class AddTitleAndDateToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :date, :date
    add_column :events, :title, :string
    add_index :events, :date
  end
end

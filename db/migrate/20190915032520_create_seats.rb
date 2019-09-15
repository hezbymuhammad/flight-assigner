class CreateSeats < ActiveRecord::Migration[5.2]
  def change
    create_table :seats do |t|
      t.belongs_to :plane, foreign_key: true
      t.integer :section_idx
      t.integer :column_idx
      t.integer :row_idx
      t.integer :queue_number
      t.boolean :occupied

      t.timestamps
    end
  end
end

class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :seat, foreign_key: true
      t.belongs_to :plane, foreign_key: true

      t.timestamps
    end
  end
end

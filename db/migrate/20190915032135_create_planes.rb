class CreatePlanes < ActiveRecord::Migration[5.2]
  def change
    create_table :planes do |t|
      t.string :dimension
      t.string :name
      t.boolean :prototype_only, default: false

      t.timestamps
    end
  end
end

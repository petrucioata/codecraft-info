class CreatePositions < ActiveRecord::Migration[5.2]
  def change
    create_table :positions do |t|
      t.string :short_name
      t.string :long_name
      t.text :description
      t.boolean :deleted, default: false

      t.timestamps
    end
    add_index :positions, :short_name, unique: true
  end
end

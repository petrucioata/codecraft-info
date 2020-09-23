class CreatePositions < ActiveRecord::Migration[5.2]
  def change
    create_table :positions do |t|
      t.string :short_name, unique: true
      t.string :long_name
      t.text :description

      t.timestamps
    end
  end
end

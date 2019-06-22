class CreateSolutions < ActiveRecord::Migration[5.2]
  def change
    create_table :solutions do |t|
      t.references :participation, foreign_key: true
      t.references :task, foreign_key: true
      t.integer :points, default: 0
      t.string :time, default: "00:00:00"

      t.timestamps
    end
  end
end

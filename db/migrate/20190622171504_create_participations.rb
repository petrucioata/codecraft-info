class CreateParticipations < ActiveRecord::Migration[5.2]
  def change
    create_table :participations do |t|
      t.references :participant, foreign_key: true
      t.references :edition, foreign_key: true
      t.integer :total_points, default: 0
      t.string :total_time, default: "00:00:00"

      t.timestamps
    end
  end
end

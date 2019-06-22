class CreateParticipations < ActiveRecord::Migration[5.2]
  def change
    create_table :participations do |t|
      t.references :participant, foreign_key: true
      t.references :edition, foreign_key: true
      t.integer :total_points
      t.string :total_time

      t.timestamps
    end
  end
end

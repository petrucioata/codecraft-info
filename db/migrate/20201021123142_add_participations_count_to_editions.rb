class AddParticipationsCountToEditions < ActiveRecord::Migration[5.2]
  def change
    add_column :editions, :participations_count, :integer
  end
end

class AddParticipationsCountToEditions < ActiveRecord::Migration[5.2]
  def up
    add_column :editions, :participations_count, :integer

    Edition.find_each do |edition|
      Edition.reset_counters(edition.id, :participations)
    end
  end

  def down
    remove_column :editions, :participations_count
  end
end

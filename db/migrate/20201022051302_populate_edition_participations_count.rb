class PopulateEditionParticipationsCount < ActiveRecord::Migration[5.2]
  def up
    Edition.find_each do |edition|
      Edition.reset_counters(edition.id, :participations)
    end
  end
end

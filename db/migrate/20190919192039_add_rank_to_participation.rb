class AddRankToParticipation < ActiveRecord::Migration[5.2]
  def change
  	add_column :participations, :rank, :integer
  end
end

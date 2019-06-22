class Participation < ApplicationRecord
  belongs_to :participant
  belongs_to :edition
  has_many :solutions

  validates :total_points, numericality: { only_integer: true }
  validates_uniqueness_of :participant_id, scope: :edition_id
end

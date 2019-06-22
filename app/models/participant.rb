class Participant < ApplicationRecord
  belongs_to :position

  has_many :participations
  has_many :editions, through: :participations
end

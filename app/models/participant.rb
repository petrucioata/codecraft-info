class Participant < ApplicationRecord
  belongs_to :position

  has_many :participations
  has_many :editions, through: :participations

  validates_uniqueness_of :username
end

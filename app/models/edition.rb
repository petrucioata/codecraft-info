class Edition < ApplicationRecord
  has_many :participations
  has_many :participants, through: :participations

  validates_uniqueness_of :name, :link
  validates_presence_of :name, :link, :date
end

class Task < ApplicationRecord
  belongs_to :edition
  has_many :solutions

  validates_uniqueness_of :name
end

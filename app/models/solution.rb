class Solution < ApplicationRecord
  belongs_to :participation
  belongs_to :task

  validates :total_points, numericality: { only_integer: true }
  validates_uniqueness_of :participation_id, scope: :task_id
end

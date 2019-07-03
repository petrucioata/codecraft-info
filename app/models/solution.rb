# frozen_string_literal: true

class Solution < ApplicationRecord
  belongs_to :participation
  belongs_to :task

  validates :total_points, numericality: { only_integer: true }
  validates :participation_id, uniqueness: { scope: :task_id }
end

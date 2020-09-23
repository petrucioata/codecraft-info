# frozen_string_literal: true

class Solution < ApplicationRecord
  belongs_to :participation
  belongs_to :task

  validates :points, numericality: { only_integer: true }
  validates :participation_id, uniqueness: { scope: :task_id }

  scope :all_not_deleted, -> { where(deleted: false) }
end

# frozen_string_literal: true

class Participation < ApplicationRecord
  belongs_to :participant
  belongs_to :edition
  has_many :solutions, dependent: :nullify

  validates :total_points, numericality: { only_integer: true }
  validates :participant_id, uniqueness: { scope: :edition_id }

  scope :with_points, -> { where('total_points > 0').count }
end

# frozen_string_literal: true

class Participation < ApplicationRecord
  belongs_to :participant
  belongs_to :edition
  has_many :solutions, dependent: :nullify

  validates :total_points, numericality: { only_integer: true }
  validates :participant_id, uniqueness: { scope: :edition_id }

  scope :all_not_deleted, -> { where(deleted: false) }
  scope :with_points, -> { where('total_points > 0').count }
  scope :by_position, ->(position_id) { where(positions: { id: position_id }) if position_id.present? }
  scope :by_name, lambda { |text|
    if text.present?
      joins(:participant)
        .where('first_name LIKE ? OR last_name LIKE ?', "%#{text}%", "%#{text}%")
    end
  }

  def self.search(params)
    by_position(params[:position_id]).by_name(params[:searched_text])
  end
end

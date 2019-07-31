# frozen_string_literal: true

class Participant < ApplicationRecord
  belongs_to :position, optional: true

  has_many :participations, dependent: :destroy
  has_many :editions, through: :participations

  validates :username, uniqueness: true

  validates :username, presence: true

  scope :by_position, ->(position_id) { where(position_id: position_id) if position_id.present? }
  scope :by_name, ->(text) { where('first_name LIKE ? or last_name LIKE ?', "%#{text}%", "%#{text}%") if text.present? }

  def position_name
    position&.short_name || 'None'
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.search(params)
    all.by_name(params[:searched_text]).by_position(params[:position_id])
  end
end

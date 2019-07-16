# frozen_string_literal: true

class Participant < ApplicationRecord
  belongs_to :position, optional: true

  has_many :participations, dependent: :destroy
  has_many :editions, through: :participations

  validates :username, uniqueness: true

  validates :username, presence: true

  def position_name
    position&.short_name || 'None'
  end

  def self.search(params)
    participants = Participant.all
    participants = participants.where('first_name LIKE ? or last_name LIKE ?', "%#{params[:searched_text]}%", "%#{params[:searched_text]}%") if params[:searched_text].present?
    participants
  end
end

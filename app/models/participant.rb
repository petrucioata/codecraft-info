# frozen_string_literal: true

class Participant < ApplicationRecord
  belongs_to :position, optional: true

  has_many :participations, dependent: :destroy
  has_many :editions, through: :participations

  validates :username, uniqueness: true

  def position_name
    position&.short_name || 'None'
  end
end

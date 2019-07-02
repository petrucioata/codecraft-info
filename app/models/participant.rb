# frozen_string_literal: true

class Participant < ApplicationRecord
  belongs_to :position

  has_many :participations, dependent: :destroy
  has_many :editions, through: :participations

  validates :username, uniqueness: true
end

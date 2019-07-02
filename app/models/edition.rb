# frozen_string_literal: true

class Edition < ApplicationRecord
  has_many :participations, dependent: :destroy
  has_many :participants, through: :participations

  has_many :tasks, dependent: :nullify

  validates :name, uniqueness: true
  validates :link, uniqueness: true

  validates :name, presence: true
  validates :link, presence: true
  validates :date, presence: true
end

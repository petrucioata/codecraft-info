# frozen_string_literal: true

class Position < ApplicationRecord
  has_many :participants, dependent: :nullify

  validates :short_name, uniqueness: true

  validates :short_name, presence: true
  validates :long_name, presence: true
end

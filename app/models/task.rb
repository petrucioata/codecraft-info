# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :edition
  has_many :solutions, dependent: :destroy

  validates :name, uniqueness: true
end

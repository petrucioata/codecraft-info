# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :edition, optional: true
  has_many :solutions, dependent: :destroy

  validates :name, uniqueness: true

  validates :name, presence: true

  def edition_name
    edition&.name || 'None'
  end
end

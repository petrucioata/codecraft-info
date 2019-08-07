# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :edition, optional: true
  has_many :solutions, dependent: :destroy
  has_many_attached :test_cases

  validates :name, uniqueness: true

  validates :name, presence: true

  scope :by_edition, ->(edition_id) { where(edition_id: edition_id) if edition_id.present? }
  scope :by_name_or_author, ->(text) { where('name LIKE ? or author LIKE ?', "%#{text}%", "%#{text}%") if text.present? }

  def edition_name
    edition&.name || 'None'
  end

  def self.search(params)
    all.by_name_or_author(params[:searched_text]).by_edition(params[:edition_id])
  end
end

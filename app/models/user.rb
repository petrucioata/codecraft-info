# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true

  scope :all_not_deleted, -> { where(deleted: false) }
end

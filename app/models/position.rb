class Position < ApplicationRecord
  validates_uniqueness_of :short_name
end

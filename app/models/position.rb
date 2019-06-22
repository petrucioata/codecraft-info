class Position < ApplicationRecord
  validates_uniqueness_of :short_name
  validates_presence_of :short_name, :long_name
end

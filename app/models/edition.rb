class Edition < ApplicationRecord
  validates_uniqueness_of :name, :link
  validates_presence_of :name, :link, :date
end

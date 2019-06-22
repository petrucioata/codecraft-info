class Participation < ApplicationRecord
  belongs_to :participant
  belongs_to :edition
end

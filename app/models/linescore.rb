class Linescore < ApplicationRecord
  has_one :game
  has_many :linescore_details
end

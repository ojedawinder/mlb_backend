class Team < ApplicationRecord
  belongs_to :venue
  belongs_to :division
end

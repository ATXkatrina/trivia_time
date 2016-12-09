class Round < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :game
  has_many :possibleanswers
end

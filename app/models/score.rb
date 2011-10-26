class Score < ActiveRecord::Base
  belongs_to :player
  belongs_to :match
  belongs_to :hole
  
  validates :player, :match, :hole, :score, :presence => true
end

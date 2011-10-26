class Team < ActiveRecord::Base
  belongs_to :match
  belongs_to :captain, :class_name => 'Player'
  belongs_to :player, :class_name => 'Player'

  validates :captain, :player, :shots_captain, :shots_player, :presence => true

  def players
    [captain, player]
  end
end

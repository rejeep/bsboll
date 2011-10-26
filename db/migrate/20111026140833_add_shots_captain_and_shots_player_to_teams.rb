class AddShotsCaptainAndShotsPlayerToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :shots_captain, :integer
    add_column :teams, :shots_player, :integer
  end
end

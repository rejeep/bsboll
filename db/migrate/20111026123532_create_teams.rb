class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.integer :match_id
      t.integer :captain_id
      t.integer :player_id

      t.timestamps
    end
  end
end

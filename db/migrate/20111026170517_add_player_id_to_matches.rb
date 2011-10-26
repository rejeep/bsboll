class AddPlayerIdToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :player_id, :integer
  end
end

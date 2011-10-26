class AddPointsForBirdieToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :points_for_birdie, :integer, :null => false, :default => 0
  end
end

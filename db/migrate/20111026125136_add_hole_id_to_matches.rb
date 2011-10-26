class AddHoleIdToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :hole_id, :integer
  end
end

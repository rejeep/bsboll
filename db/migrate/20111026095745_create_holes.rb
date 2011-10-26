class CreateHoles < ActiveRecord::Migration
  def change
    create_table :holes do |t|
      t.integer :nr
      t.integer :hcp
      t.integer :par
      t.integer :course_id

      t.timestamps
    end
  end
end

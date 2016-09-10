class CreateLinescoreDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :linescore_details do |t|
      t.integer :linescore_id
      t.integer :inning
      t.integer :r_home
      t.integer :r_away

      t.timestamps
    end
  end
end

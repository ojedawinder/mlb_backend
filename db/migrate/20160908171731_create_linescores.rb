class CreateLinescores < ActiveRecord::Migration[5.0]
  def change
    create_table :linescores do |t|
      t.integer :e_home
      t.integer :e_away
      t.integer :r_home
      t.integer :r_away
      t.integer :h_home
      t.integer :h_away
      t.integer :inning
      t.integer :game_id

      t.timestamps
    end
  end
end

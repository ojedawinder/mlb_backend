class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.integer :code
      t.string :gameday
      t.string :home_time
      t.string :original_date
      t.string :day
      t.integer :home_team_code
      t.integer :away_team_code
      t.integer :team_id_win
      t.integer :team_id_loss
      t.string :status

      t.timestamps
    end
  end
end

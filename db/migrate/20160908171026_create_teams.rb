class CreateTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :teams do |t|
      t.integer :code
      t.string :name
      t.integer :win
      t.integer :loss
      t.integer :away_win
      t.integer :home_win
      t.integer :away_loss
      t.integer :home_loss
      t.integer :division_id
      t.integer :venue_id
      t.string :team_image
      t.timestamps
    end
  end
end

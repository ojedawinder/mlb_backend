class CreateTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :teams do |t|
      t.string :name
      t.integer :division_id
      t.integer :venue_id
      t.string :team_image
      t.timestamps
    end
    change_column :teams, :id, :integer
  end
end

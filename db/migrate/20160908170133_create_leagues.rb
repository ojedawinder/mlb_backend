class CreateLeagues < ActiveRecord::Migration[5.0]
  def change
    create_table :leagues do |t|
      t.string :name
      t.timestamps
    end
    change_column :leagues, :id, :integer
  end
end

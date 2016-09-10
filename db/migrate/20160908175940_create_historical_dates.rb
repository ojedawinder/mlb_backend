class CreateHistoricalDates < ActiveRecord::Migration[5.0]
  def change
    create_table :historical_dates do |t|
      t.string :code

      t.timestamps
    end
  end
end

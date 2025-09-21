class CreateWeatherPredictions < ActiveRecord::Migration[7.2]
  def change
    create_table :weather_predictions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :main, null: false
      t.decimal :temperature, precision: 5, scale: 2
      t.decimal :humidity, precision: 5, scale: 2
      t.decimal :pressure, precision: 7, scale: 2

      t.timestamps
    end
  end
end

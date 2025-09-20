class CreateSymptoms < ActiveRecord::Migration[7.2]
  def change
    create_table :symptoms do |t|
      t.string :name, null: false
      t.string :display_name, null: false

      t.timestamps
    end
  end
end

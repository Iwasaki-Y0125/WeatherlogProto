class CreateSymptoms < ActiveRecord::Migration[7.2]
  def change
    create_table :symptoms do |t|
      t.integer :symptom, null: false
      t.references :user, foreign_key: true
      t.references :diaries, foreign_key: true

      t.timestamps
    end
  end
end

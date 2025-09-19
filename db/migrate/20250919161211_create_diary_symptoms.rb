class CreateDiarySymptoms < ActiveRecord::Migration[7.2]
  def change
    create_table :diary_symptoms do |t|
      t.references :diary, null: false, foreign_key: true
      t.references :symptom, null: false, foreign_key: true
      t.integer :symptom_level, null: false
      t.string :oneline_diary

      t.timestamps
    end
  end
end

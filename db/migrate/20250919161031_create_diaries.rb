class CreateDiaries < ActiveRecord::Migration[7.2]
  def change
    create_table :diaries do |t|
      t.references :user, null: false, foreign_key: true
      t.references :weather, foreign_key: true
      t.integer :symptom_level, null: false
      t.string :oneline_diary

      t.timestamps
    end
  end
end

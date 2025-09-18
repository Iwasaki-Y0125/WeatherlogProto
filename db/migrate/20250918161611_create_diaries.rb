class CreateDiaries < ActiveRecord::Migration[7.2]
  def change
    create_table :diaries do |t|
      t.integer :symptom_level, null: false
      t.string :oneline_diary
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

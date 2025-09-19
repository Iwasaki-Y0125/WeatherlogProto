class CreateUserSymptoms < ActiveRecord::Migration[7.2]
  def change
    create_table :user_symptoms do |t|
      t.references :user, null: false, foreign_key: true
      t.references :symptom, null: false, foreign_key: true

      t.timestamps
    end
  end
end

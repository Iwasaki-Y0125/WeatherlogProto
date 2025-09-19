class CreateSymptoms < ActiveRecord::Migration[7.2]
  def change
    create_table :symptoms do |t|
      t.string :name, null: false
      t.string :display_name, null: false

      t.timestamps
    end

    # 初期データの投入
    # モデルクラスへの依存を避けるためSQLで実行
    reversible do |dir|
      dir.up do
        # マイグレーション実行時に初期データを作成
        symptoms_data = [
          { name: "mood", display_name: "気分" },
          { name: "headache", display_name: "頭痛" },
          { name: "sleep", display_name: "睡眠" },
          { name: "joint_pain", display_name: "関節痛" }
        ]

        symptoms_data.each do |symptom_data|
          execute <<-SQL
            INSERT INTO symptoms (name, display_name, created_at, updated_at)
            VALUES ('#{symptom_data[:name]}', '#{symptom_data[:display_name]}', NOW(), NOW())
          SQL
        end
      end

      dir.down do
        # ロールバック時に作成したデータを削除
        execute "DELETE FROM symptoms WHERE name IN ('mood', 'headache', 'sleep', 'joint_pain')"
      end
    end
  end
end

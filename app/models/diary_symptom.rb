class DiarySymptom < ApplicationRecord
  belongs_to :diary
  belongs_to :symptom

  # 症状レベルのenum
  enum symptom_level: {
    very_mild: 1,
    mild: 2,
    moderate: 3,
    somewhat_severe: 4,
    severe: 5,
    very_severe: 6
  }

  # バリデーション
  validates :symptom_level, presence: true
  validates :oneline_diary, length: { maximum: 100, message: "は100文字以内で入力してください"  }, allow_blank: true
end

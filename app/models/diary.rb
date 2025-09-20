class Diary < ApplicationRecord
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
  validates :symptom_level, inclusion: { in: 1..6 }
  validates :oneline_diary, length: { maximum: 100 }, allow_blank: true
end

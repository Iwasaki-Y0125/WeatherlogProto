class Diary < ApplicationRecord
  belongs_to :user
  belongs_to :weather, optional: true  # 天気情報がない場合もあるので optional

  # 症状レベルのenum
  enum symptom_level: {
    very_good: 1,
    good: 2,
    neutral: 3,
    bad: 4,
    very_bad: 5
  }

  # バリデーション
  validates :symptom_level, presence: true
  validates :oneline_diary, length: { maximum: 100 }, allow_blank: true
end

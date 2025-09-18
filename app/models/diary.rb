class Diary < ApplicationRecord
  validates :oneline_diary, length: { maximum: 150 }

  belongs_to :user
  has_many :symptoms, dependent: :destroy
end

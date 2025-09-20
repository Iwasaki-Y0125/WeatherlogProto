class Diary < ApplicationRecord
  belongs_to :user
  belongs_to :weather
  has_many :diary_symptoms, dependent: :destroy
  has_many :symptoms, through: :diary_symptoms

  accepts_nested_attributes_for :diary_symptoms, allow_destroy: true
end

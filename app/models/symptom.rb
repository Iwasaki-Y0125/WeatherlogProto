class Symptom < ApplicationRecord
  has_many :user_symptoms, dependent: :destroy
  has_many :users, through: :user_symptoms
  has_many :diary_symptoms, dependent: :destroy
end

class DiarySymptom < ApplicationRecord
  belongs_to :diary
  belongs_to :symptom
end

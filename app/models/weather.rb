class Weather < ApplicationRecord
  belongs_to :user
  has_many :diaries
end

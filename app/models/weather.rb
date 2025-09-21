class Weather < ApplicationRecord
  belongs_to :user
  has_many :dairies
end

class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :email, uniqueness: true, presence: true
  validates :postal_code, presence: true,
            format: { with: /\A\d{7}\z/ },
            length: { is: 7 }

  has_many :diaries, dependent: :destroy
  has_many :weathers, dependent: :destroy

  before_save :set_coordinates_from_postal_code

  private

  def set_coordinates_from_postal_code
    return unless postal_code_changed? && postal_code.present?

    coordinates = fetch_coordinates_from_postal_code(postal_code)
    if coordinates
      self.latitude = coordinates[:latitude]
      self.longitude = coordinates[:longitude]
    end
  end

  def fetch_coordinates_from_postal_code(postal_code)
    require 'net/http'
    require 'json'

    uri = URI("https://geoapi.heartrails.com/api/json?method=searchByPostal&postal=#{postal_code}")

    begin
      response = Net::HTTP.get_response(uri)
      return nil unless response.code == '200'

      data = JSON.parse(response.body)
      if data['response'] && data['response']['location'] && data['response']['location'].any?
        location = data['response']['location'].first
        {
          latitude: location['y'].to_f,
          longitude: location['x'].to_f
        }
      else
        nil
      end
    rescue => e
      Rails.logger.error "Failed to fetch coordinates for postal code #{postal_code}: #{e.message}"
      nil
    end
  end
end

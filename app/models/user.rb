class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :password, length: { minimum: 8 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :email, uniqueness: true, presence: true
  validates :postalcode, presence: true,
            format: { with: /\A\d{7}\z/, message: "は7桁の数字で入力してください" },
            length: { is: 7 }

  has_many :diary :symptom, dependent: :destroy
  has_many :symptoms, dependent: :destroy
  has_many :symptom_diaries, through: :symptom, source: :diaries
end

class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :email, uniqueness: true, presence: true
  validates :postal_code, presence: true,
            format: { with: /\A\d{7}\z/},
            length: { is: 7 }

  has_many :user_symptoms, dependent: :destroy
  has_many :symptoms, through: :user_symptoms
  has_many :diaries, dependent: :destroy

  accepts_nested_attributes_for :user_symptoms, allow_destroy: true, reject_if: :all_blank
end

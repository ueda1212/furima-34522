class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'には英字と数字の両方を含めて設定してください' 

  with_options presence: true do
    validates :birthday
    validates :nickname
  
    with_options format: { with: /\A[ぁ-んァ-ヶ一-龥々]+\z/, message: '全角文字を使用してください' } do
      validates :family_name
      validates :first_name
    end

    with_options format: { with: /\A[ァ-ヴ]+\z/, message: '全角文字を使用してください' } do
      validates :family_name_kana
      validates :first_name_kana
    end
  end
  
  has_many :items
  has_many :records
end
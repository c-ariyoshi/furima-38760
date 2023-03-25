class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         validates :nickname, presence: true
         validates :family_name, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: '全角ひらがな、全角カタカナ、漢字で入力して下さい' }
         validates :first_name, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: '全角ひらがな、全角カタカナ、漢字で入力して下さい' }
         validates :family_name_kana, presence: true, format: { with: /\A[ァ-ヶー]+\z/, message: '全角カタカナで入力して下さい' }
         validates :first_name_kana, presence: true, format: { with: /\A[ァ-ヶー]+\z/, message: '全角カタカナで入力して下さい' }
         validates :birth_day, presence: true
         validates :password, format: {with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i, message: '半角英数を両方含む必要があります'} 
         
         
end
require 'rails_helper'

RSpec.describe User, type: :model do
  describe '新規登録' do
    before do
      @user = FactoryBot.build(:user)
    end

    context '内容に問題ない場合' do
      it "すべての情報があれば登録できる" do
        expect(@user).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it "nicknameが空だと保存できない" do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it "emailが空では登録できない" do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it "重複したemailが存在する場合は登録できない" do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it "emailに@を含まないと登録できない" do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it "passwordが空では登録できない" do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it "passwordが5文字以下では登録できない" do
        @user.password = '00000'
        @user.password_confirmation = '00000'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it "passwordが英語のみでは登録できない" do
        @user.password = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password 半角英数を両方含む必要があります")
      end
      it "passwordが数字のみでは登録できない" do
        @user.password = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password 半角英数を両方含む必要があります")
      end
      it "passwordが全角では登録できない" do
        @user.password = 'ああああああ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password 半角英数を両方含む必要があります")
      end
      it "passwordとpassword_confirmationが不一致では登録できない" do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "family_nameが空だと保存できない" do
        @user.family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank")
      end
      it "first_nameが空だと保存できない" do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it "family_nameが全角日本語でないと保存できない" do
        @user.family_name = 'suzuki'
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name 全角ひらがな、全角カタカナ、漢字で入力して下さい")
      end
      it "first_nameが全角日本語でないと保存できない" do
        @user.first_name = 'taro'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name 全角ひらがな、全角カタカナ、漢字で入力して下さい")
      end
      it "family_name_kanaが空だと保存できないこと" do
        @user.family_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana can't be blank")
      end
      it "first_name_kanaが空だと保存できないこと" do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it "family_name_kanaが全角カタカナでないと保存できないこと" do
        @user.family_name_kana = 'すずき'
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana 全角カタカナで入力して下さい")
      end
      it "first_name_kanaが全角カタカナでないと保存できないこと" do
        @user.first_name_kana = 'たろう'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana 全角カタカナで入力して下さい")
      end
      it "birth_dayが空だと保存できないこと" do
        @user.birth_day = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth day can't be blank")
      end 
    end
   end
  end
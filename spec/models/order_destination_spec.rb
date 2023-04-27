require 'rails_helper'

RSpec.describe OrderDestination, type: :model do
  describe '購入機能' do
    before do
      @item = FactoryBot.create(:item)
      @user = FactoryBot.create(:user)
      @order_destination = FactoryBot.build(:order_destination, user_id: @user.id, item_id: @item.id)
    end

    context '内容に問題ない場合' do
      it "すべての情報があれば登録できる" do
        expect(@order_destination).to be_valid
      end
      it "建物名が空の場合でも保存できる" do
        @order_destination.building_name = ''
        @order_destination.valid?
        expect(@order_destination).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it "post_codeが空だと登録できない" do
        @order_destination.post_code = ''
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Post code can't be blank")
      end
      it "post_code が半角ハイフンを含んだ形式でないと保存できない" do
        @order_destination.post_code = '123ー4567'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Post code is invalid")
      end
      it "prefectureが空だと保存できない" do
        @order_destination.prefecture_id = '1'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Prefecture must be other than 1")
      end
      it "cityが空だと保存できない" do
        @order_destination.city = ''
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("City can't be blank")
      end
      it "addressが空だと保存できない" do
        @order_destination.address = ''
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Address can't be blank")
      end
      it "phone_numberが空だと保存できない" do
        @order_destination.phone_number = ''
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Phone number can't be blank")
      end
      it "phone_number が全角だと保存できない" do
        @order_destination.phone_number = '１２３４５６７８９００'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Phone number is invalid.Input only number")
      end
      it "phone_numberが10桁又は11桁の数値でなければ保存できない" do
        @order_destination.phone_number = '123456789'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Phone number is too short")
      end
      it "phone_numberが12桁以上では保存できない" do
        @order_destination.phone_number = '123456789000'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Phone number is too short")
      end
      it "user_id が空では登録できない" do
        @order_destination.user_id = nil
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("User can't be blank")
      end
      it "item_id が空では登録できない" do
        @order_destination.item_id = nil
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Item can't be blank")
      end
      it "tokenが空では登録できない" do
        @order_destination.token = nil
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
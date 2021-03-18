require 'rails_helper'

RSpec.describe BuyerDonation, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @buyer_donation = FactoryBot.build(:buyer_donation, user_id: user.id, item_id: item.id)
    sleep(1)
  end

  describe '購入者情報'do
    context '購入者情報が登録できるとき' do
      it 'token,post_code,area_id,municipality,address,phone_numberが存在すれば登録できる' do
        expect(@buyer_donation).to be_valid
      end

      it 'building_nameが空でも登録できる' do
        @buyer_donation.building_name = ""
        expect(@buyer_donation).to be_valid
      end

      it 'phone_numberが11文字以下なら登録できる' do
        @buyer_donation.phone_number = "00000000000"
        expect(@buyer_donation).to be_valid
      end
    end

      context '購入者情報が登録できないとき' do
        it "tokenが空では登録できないこと" do
          @buyer_donation.token = ""
          @buyer_donation.valid?
          expect(@buyer_donation.errors.full_messages).to include("Token can't be blank")
        end

        it 'post_codeが空では登録できない' do
          @buyer_donation.post_code = ""
          @buyer_donation.valid?
          expect(@buyer_donation.errors.full_messages).to include("Post code can't be blank")
        end

        it 'post_codeにハイフンがないと登録できない' do
          @buyer_donation.post_code = "0000000"
          @buyer_donation.valid?
          expect(@buyer_donation.errors.full_messages).to include("Post code is invalid. Include hyphen(-)")
        end

        it 'postcodeが全角だと登録できない' do
          @buyer_donation.post_code = "０１２３ー４５６７８９０"
          @buyer_donation.valid?
          expect(@buyer_donation.errors.full_messages).to include("Post code is invalid. Include hyphen(-)")
        end

        it 'area_idがないと登録できない' do
          @buyer_donation.area_id = 1
          @buyer_donation.valid?
          expect(@buyer_donation.errors.full_messages).to include("Area must be other than 1")
        end

          it 'municipalityが空だと登録できない' do
            @buyer_donation.municipality = ""
            @buyer_donation.valid?
            expect(@buyer_donation.errors.full_messages).to include("Municipality can't be blank")
          end

          it 'addressが空だと登録できない' do
            @buyer_donation.address = ""
            @buyer_donation.valid?
            expect(@buyer_donation.errors.full_messages).to include("Address can't be blank")
          end

          it 'phone_numberが空だと登録できない' do
            @buyer_donation.phone_number = ""
            @buyer_donation.valid?
            expect(@buyer_donation.errors.full_messages).to include("Phone number can't be blank")
          end

          it 'phone_numberが12文字以上だと登録できない' do
            @buyer_donation.phone_number = "123456789100"
            @buyer_donation.valid?
            expect(@buyer_donation.errors.full_messages).to include("Phone number is invalid")
          end

          it 'phone_numberが全角だと登録できない' do
            @buyer_donation.phone_number = "０１２３４５６７８９０"
            @buyer_donation.valid?
            expect(@buyer_donation.errors.full_messages).to include("Phone number is invalid")
          end

          it 'phone_numberが英数混合だと登録できない' do
            @buyer_donation.phone_number = "123456abcde"
            @buyer_donation.valid?
            expect(@buyer_donation.errors.full_messages).to include("Phone number is invalid")
          end

          it 'user_idが空だと登録できない' do
            @buyer_donation.user_id = ""
            @buyer_donation.valid?
            expect(@buyer_donation.errors.full_messages).to include("User can't be blank")
          end

          it 'item_idが空だと登録できない' do
            @buyer_donation.item_id = ""
            @buyer_donation.valid?
            expect(@buyer_donation.errors.full_messages).to include("Item can't be blank")
          end

      end
  end
end
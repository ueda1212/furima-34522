require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  
  describe 'ユーザー新規登録'do
    context '新規登録できるとき' do
      it 'nicknameとemail、passwordとpassword_confirmation、famiiy_nameとfirst_name、famiiy_name_kanaとfirst_name_kana、birthdayが存在すれば登録できる' do
        expect(@user).to be_valid
      end

      it 'passwordとpassword_confirmationが6文字以上であれば登録できる' do
        @user.password = '000000a'
        @user.password_confirmation = '000000a'
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'emailが空では登録できない' do
      @user.email= ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'emailに＠がないと登録できない' do
        @user.email= "sample.gmail.com"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
        end

      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'passwordが存在してもpassword_confirmationが空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'passwordが5文字以下では登録できない' do
        @user.password = '0000a'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'passwordが数字のみでは登録できない' do
        @user.password = '000000'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password には英字と数字の両方を含めて設定してください")
      end

        it 'passwordが半角英語のみでは登録できない' do
          @user.password = 'abcdef'
          @user.valid?
          expect(@user.errors.full_messages).to include("Password には英字と数字の両方を含めて設定してください")
        end

        it 'passwordが全角英数混合では登録できない' do
          @user.password = 'ａｂｃ１２３'
          @user.valid?
          expect(@user.errors.full_messages).to include("Password には英字と数字の両方を含めて設定してください")
        end

        it "passwordとpassword_confirmationが不一致では登録できない" do
          @user.password = "a23456"
          @user.password_confirmation = "a234567"
          @user.valid?
          expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
        end

      it "family_nameが空だと登録できない" do
        @user.family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank")
      end

      it "first_nameが空だと登録できない" do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it "famiiy_name_kanaが空だと登録できない" do
        @user.family_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana can't be blank")
      end

      it "first_name_kanaが空だと登録できない" do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end

      it 'family_nameが全角入力でなければ登録できないこと' do
        @user.family_name = "aiueo"
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name 全角文字を使用してください")
      end

      it 'first_nameが全角入力でなければ登録できないこと' do
        @user.first_name = "aiueo"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name 全角文字を使用してください")
      end

      it 'family_name_kanaが全角カタカナでなければ登録できないこと' do
        @user.family_name_kana = "あいうえお"
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana 全角文字を使用してください")
      end

      it 'first_name_kanaが全角カタカナでなければ登録できないこと' do
        @user.first_name_kana = "あいうえお"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana 全角文字を使用してください")
      end

      it "birthdayが空だと登録できない" do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end

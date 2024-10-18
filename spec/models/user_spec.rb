require 'rails_helper'

RSpec.describe 'ユーザー登録', type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  context 'ユーザー登録が成功する場合' do
    it 'すべての必須項目が正しく入力されていれば登録できる' do
      expect(@user).to be_valid
    end

    it '自己紹介が空でも登録できる' do
      @user.bio = ''
      expect(@user).to be_valid
    end

    it 'アバター画像が無くても登録できる' do
      @user.avatar = nil
      expect(@user).to be_valid
    end

    it 'nicknameに一意性がなくても登録できる' do
      @user.save
      another_user = FactoryBot.build(:user, nickname: @user.nickname)
      expect(another_user).to be_valid
    end

  end

  context 'ユーザー登録が失敗する場合' do
    it 'account_nameが空では登録できない' do
      @user.account_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Account name can't be blank")
    end

    it 'account_nameが8文字未満では登録できない' do
      @user.account_name = 'short'
      @user.valid?
      expect(@user.errors.full_messages).to include('Account name must be between 8 and 16 characters')
    end

    it 'account_nameが16文字を超えると登録できない' do
      @user.account_name = 'a' * 17
      @user.valid?
      expect(@user.errors.full_messages).to include('Account name must be between 8 and 16 characters')
    end

    it 'account_nameが英数字以外を含むと登録できない' do
      @user.account_name = 'invalid_name!'
      @user.valid?
      expect(@user.errors.full_messages).to include('Account name can only contain alphanumeric characters')
    end

    it 'account_nameが一意でないと登録できない' do
      another_user = FactoryBot.create(:user, account_name: 'uniqueUser')
      @user.account_name = another_user.account_name
      @user.valid?
      expect(@user.errors.full_messages).to include('Account name has already been taken')
    end

    it 'nicknameが空では登録できない' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end

    it 'nicknameが10文字を超えると登録できない' do
      @user.nickname = 'a' * 11
      @user.valid?
      expect(@user.errors.full_messages).to include('Nickname is too long (maximum is 10 characters)')
    end

    it 'nicknameにスペースが含まれると登録できない' do
      @user.nickname = 'nickname with space'
      @user.valid?
      expect(@user.errors.full_messages).to include('Nickname cannot contain spaces')
    end

    it 'emailが空では登録できない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'emailが一意でないと登録できない' do
      another_user = FactoryBot.create(:user, email: 'duplicate_email@example.com')
      @user.email = another_user.email
      @user.valid?
      expect(@user.errors.full_messages).to include('Email has already been taken')
    end

    it 'passwordが空では登録できない' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'passwordが8文字未満では登録できない' do
      @user.password = 'short'
      @user.password_confirmation = 'short'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end

    it 'passwordとpassword_confirmationが一致していないと登録できない' do
      @user.password = 'Password1'
      @user.password_confirmation = 'Password2'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'bioが100文字を超えると登録できない' do
      @user.bio = 'a' * 101
      @user.valid?
      expect(@user.errors.full_messages).to include('Bio is too long (maximum is 100 characters)')
    end

    it 'アバター画像のサイズが5MBを超えると登録できない' do
      allow(@user.avatar).to receive(:byte_size).and_return(6.megabytes)
      @user.valid?
      expect(@user.errors.full_messages).to include('Avatar must be less than 5MB')
    end

    it 'アバター画像がJPEG, GIF, PNG以外の形式だと登録できない' do
      allow(@user.avatar).to receive(:content_type).and_return('image/bmp')
      @user.valid?
      expect(@user.errors.full_messages).to include('Avatar must be a JPEG, GIF, or PNG')
    end
  end
end
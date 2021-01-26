require 'rails_helper'

RSpec.describe 'Userモデルのテスト', type: :model do
  describe 'バリデーションテスト' do
    subject { user.valid? }
    let!(:other_user) { create(:user) }
    let(:user) { build(:user) }
    context 'nameカラム' do
      it 'ユーザーネームが空白であれば登録×' do
        user.name = ''
        is_expected.to eq false
      end
      it 'ユーザーネームが1文字であれば登録◯' do
        user.name = SecureRandom.alphanumeric(1)
        is_expected.to eq true
      end
      it 'ユーザーネームが6文字であれば登録◯' do
        user.name = SecureRandom.alphanumeric(6)
        is_expected.to eq true
      end
      it 'ユーザーネームが7文字であれば登録×' do
        user.name = SecureRandom.alphanumeric(7)
        is_expected.to eq false
      end
      it '重複したユーザーネームは登録×' do
        user.name = other_user.name
        is_expected.to eq false
      end
    end
    context 'emailカラム' do
      it 'メールアドレスが空白であれば登録×' do
        user.email = ""
        is_expected.to eq false
      end
      it '重複したメールアドレスは登録×' do
        user.email = other_user.email
        is_expected.to eq false
      end
    end
    context 'residenceカラム' do
      it '居住地はデフォルト("---")でも登録◯' do
        user.residence = 0
        is_expected.to eq true
      end
    end
    context 'profile_imageカラム' do
      it 'プロフィール画像は空白でも登録◯' do
        user.profile_image = ""
        is_expected.to eq true
      end
    end
    context 'passwordカラム' do
      it 'パスワードが空白であれば登録×' do
        user.password = ''
        is_expected.to eq false
      end
      it 'パスワードが5文字であれば登録×' do
        user.password = SecureRandom.alphanumeric(5)
        user.password_confirmation = user.password
        is_expected.to eq false
      end
      it 'パスワードが6文字であれば登録◯' do
        user.password = SecureRandom.alphanumeric(6)
        user.password_confirmation = user.password
        is_expected.to eq true
      end
      it 'パスワードと再入力パスワードが異なる場合登録×' do
        user.password_confirmation = user.password + SecureRandom.alphanumeric(1)
        is_expected.to eq false
      end
    end
  end
  describe 'アソシエーションテスト' do
    context 'モデルとの関係' do
      it 'User:Post = 1:N' do
        expect(User.reflect_on_association(:posts).macro).to eq :has_many
      end
      it 'User:Murmur = 1:N' do
        expect(User.reflect_on_association(:murmurs).macro).to eq :has_many
      end
      it 'User:Favorite = 1:N' do
        expect(User.reflect_on_association(:favorites).macro).to eq :has_many
      end
      it 'User:Review = 1:N' do
        expect(User.reflect_on_association(:reviews).macro).to eq :has_many
      end
      it 'User:Followers = 1:N (User同士の中間テーブル接続)' do
        expect(User.reflect_on_association(:followers).macro).to eq :has_many
      end
      it 'User:Followings = 1:N (User同士の中間テーブル接続)' do
        expect(User.reflect_on_association(:followings).macro).to eq :has_many
      end
    end
  end
end
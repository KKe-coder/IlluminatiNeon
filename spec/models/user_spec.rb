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
        user.name = Faker::Lorem.characters(number:1)
        is_expected.to eq true
      end
      it 'ユーザーネームが6文字であれば登録◯' do
        user.name = Faker::Lorem.characters(number:6)
        is_expected.to eq true
      end
      it 'ユーザーネームが7文字であれば登録×' do
        user.name = Faker::Lorem.characters(number:7)
        is_expected.to eq false
      end
      it '重複したユーザーネームは登録×' do
        user.name = other_user.name
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
      it 'User:Relationship = 1:N' do
        expect(User.reflect_on_association(:relationships).macro).to eq :has_many
      end
    end
  end
end
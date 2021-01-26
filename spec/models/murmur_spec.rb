require 'rails_helper'

RSpec.describe 'Murmurモデルのテスト', type: :model do
  describe 'バリデーションテスト' do
    subject { murmur.valid? }
    let(:user) { create(:user) }
    let!(:murmur) { build(:murmur, user_id: user.id) }
    context 'bodyカラム' do
      it 'つぶやきが空白であれば登録×' do
        murmur.body = ''
        is_expected.to eq false
      end
      it 'つぶやきが1文字であれば登録◯' do
        murmur.body = Faker::Lorem.characters(number:1)
        is_expected.to eq true
      end
      it 'つぶやきが30文字であれば登録◯' do
        murmur.body = Faker::Lorem.characters(number:30)
        is_expected.to eq true
      end
      it 'つぶやきが31文字であれば登録×' do
        murmur.body = Faker::Lorem.characters(number:31)
        is_expected.to eq false
      end
    end
  end
  describe 'アソシエーションテスト' do
    context 'モデルとの関係' do
      it 'Murmur:User = N:1' do
        expect(Murmur.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end
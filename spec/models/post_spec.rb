require 'rails_helper'

RSpec.describe 'Postモデルのテスト', type: :model do
  describe 'バリデーションテスト' do
    subject { post.valid? }
    let(:user) { create(:user) }
    let!(:post) { build(:post, user_id: user.id) }
    context 'titleカラム' do
      it 'タイトルが空白であれば登録×' do
        post.title = ''
        is_expected.to eq false
      end
      it 'タイトルが1文字であれば登録◯' do
        post.title = Faker::Lorem.characters(number:1)
        is_expected.to eq true
      end
      it 'タイトルが7文字であれば登録◯' do
        post.title = Faker::Lorem.characters(number:7)
        is_expected.to eq true
      end
      it 'タイトルが8文字であれば登録×' do
        post.title = Faker::Lorem.characters(number:8)
        is_expected.to eq false
      end
    end
    context 'imageカラム' do
      it '画像が空白であれば登録×' do
        post.image = ""
        is_expected.to eq false
      end
    end
    context 'categoryカラム' do
      it 'タイプが選択されなければ登録×' do
        post.category = ""
        is_expected.to eq false
      end
    end
    context 'colorカラム' do
      it 'カラーが選択されなければ登録×' do
        post.color = ""
        is_expected.to eq false
      end
    end
    context 'rateカラム' do
      it '評価が無ければ登録×' do
        post.rate = ""
        is_expected.to eq false
      end
      it '評価が0ならば登録×' do
        post.rate = 0
        is_expected.to eq false
      end
      it '評価が0.5ならば登録◯' do
        post.rate = 0.5
        is_expected.to eq true
      end
      it '評価が5ならば登録◯' do
        post.rate = 5
        is_expected.to eq true
      end
      it '評価が6ならば登録×' do
        post.rate = 6
        is_expected.to eq false
      end
    end
    context 'impressionカラム' do
      it '感想が空白であれば登録×' do
        post.impression = ""
        is_expected.to eq false
      end
      it '感想が1文字であれば登録◯' do
        post.impression = Faker::Lorem.characters(number:1)
        is_expected.to eq true
      end
      it '感想が100文字であれば登録◯' do
        post.impression = Faker::Lorem.characters(number:100)
        is_expected.to eq true
      end
      it '感想が101文字であれば登録×' do
        post.impression = Faker::Lorem.characters(number:101)
        is_expected.to eq false
      end
    end
  end
  describe 'アソシエーションテスト' do
    context 'モデルとの関係' do
      it 'Post:User = N:1' do
        expect(Post.reflect_on_association(:user).macro).to eq :belongs_to
      end
      it 'Post:Favorite = 1:N' do
        expect(Post.reflect_on_association(:favorites).macro).to eq :has_many
      end
      it 'Post:Review = 1:N' do
        expect(Post.reflect_on_association(:reviews).macro).to eq :has_many
      end
      it 'Post:Review = 1:N' do
        expect(Post.reflect_on_association(:reviews).macro).to eq :has_many
      end
      it 'Post:Review = 1:N' do
        expect(Post.reflect_on_association(:reviews).macro).to eq :has_many
      end
    end
  end
end
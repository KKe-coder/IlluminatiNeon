require 'rails_helper'

RSpec.describe 'Reviewモデルのテスト', type: :model do
  describe 'バリデーションテスト' do
    subject { review.valid? }
    let(:user) { create(:user) }
    let(:post) { create(:post, user_id: user.id) }
    let!(:review) { build(:review, user_id: user.id, post_id: post.id) }
    context 'commentカラム' do
      it 'コメントが空白であれば登録×' do
        review.comment = ''
        is_expected.to eq false
      end
      it 'コメントが1文字であれば登録◯' do
        review.comment = Faker::Lorem.characters(number:1)
        is_expected.to eq true
      end
      it 'コメントが20文字であれば登録◯' do
        review.comment = Faker::Lorem.characters(number:20)
        is_expected.to eq true
      end
      it 'タイトルが21文字であれば登録×' do
        review.comment = Faker::Lorem.characters(number:21)
        is_expected.to eq false
      end
    end
    context 'rateカラム' do
      it '評価が無ければ登録×' do
        review.rate = ""
        is_expected.to eq false
      end
      it '評価が0ならば登録×' do
        review.rate = 0
        is_expected.to eq false
      end
      it '評価が0.5ならば登録◯' do
        review.rate = 0.5
        is_expected.to eq true
      end
      it '評価が5ならば登録◯' do
        review.rate = 5
        is_expected.to eq true
      end
      it '評価が6ならば登録×' do
        review.rate = 6
        is_expected.to eq false
      end
    end
  end
  describe 'アソシエーションテスト' do
    context 'モデルとの関係' do
      it 'Review:User = N:1' do
        expect(Review.reflect_on_association(:user).macro).to eq :belongs_to
      end
      it 'Review:Post = N:1' do
        expect(Review.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end
  end
end
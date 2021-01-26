require 'rails_helper'

RSpec.describe 'Favoriteモデルのテスト', type: :model do
  describe 'アソシエーションテスト' do
    subject { favorite.valid? }
    let(:user) { create(:user) }
    let(:post) { create(:post, user_id: user.id) }
    let!(:favorite) { build(:favorite, user_id: user.id, post_id: post.id) }
    context 'モデルとの関係' do
      it 'Favorite:User = N:1' do
        expect(Favorite.reflect_on_association(:user).macro).to eq :belongs_to
      end
      it 'Favorite:Post = N:1' do
        expect(Favorite.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end
  end
end
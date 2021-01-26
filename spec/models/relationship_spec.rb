require 'rails_helper'

RSpec.describe 'Relationshipモデルのテスト', type: :model do
  describe 'アソシエーションテスト' do
    subject { relationship.valid? }
    let(:user) { create(:user) }
    let!(:other_user) { create(:user) }
    let!(:relationship) { build(:relationship, follower_id: user.id, followed_id: other_user.id) }
    context 'モデルとの関係' do
      it 'Relationship:Follower = N:1 (User同士の中間テーブル接続)' do
        expect(Relationship.reflect_on_association(:follower).macro).to eq :belongs_to
      end
      it 'Relationship:Followed = N:1 (User同士の中間テーブル接続)' do
        expect(Relationship.reflect_on_association(:followed).macro).to eq :belongs_to
      end
    end
  end
end
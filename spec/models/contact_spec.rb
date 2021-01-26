require 'rails_helper'

RSpec.describe 'Contactモデルのテスト', type: :model do
  describe 'バリデーションテスト' do
    subject { contact.valid? }
    let(:contact) { build(:contact) }
    context 'nameカラム' do
      it 'お名前が空白であれば登録×' do
        contact.name = ''
        is_expected.to eq false
      end
      it 'お名前が1文字であれば登録◯' do
        contact.name = SecureRandom.alphanumeric(1)
        is_expected.to eq true
      end
      it 'お名前が10文字であれば登録◯' do
        contact.name = SecureRandom.alphanumeric(10)
        is_expected.to eq true
      end
      it 'お名前が11文字であれば登録×' do
        contact.name = SecureRandom.alphanumeric(11)
        is_expected.to eq false
      end
    end
    context 'emailカラム' do
      it 'メールアドレスが空白であれば登録×' do
        contact.email = ""
        is_expected.to eq false
      end
      it 'メールアドレスが1文字であれば登録◯' do
        contact.email = SecureRandom.alphanumeric(1)
        is_expected.to eq true
      end
      it 'メールアドレスが50文字であれば登録◯' do
        contact.email = SecureRandom.alphanumeric(50)
        is_expected.to eq true
      end
      it 'メールアドレスが51文字であれば登録×' do
        contact.email = SecureRandom.alphanumeric(51)
        is_expected.to eq false
      end
    end
    context 'messageカラム' do
      it 'お問い合わせ内容が空白であれば登録×' do
        contact.message = ""
        is_expected.to eq false
      end
      it 'お問い合わせ内容が1文字であれば登録◯' do
        contact.message = SecureRandom.alphanumeric(1)
        is_expected.to eq true
      end
      it 'お問い合わせ内容が200文字であれば登録◯' do
        contact.message = SecureRandom.alphanumeric(200)
        is_expected.to eq true
      end
      it 'お問い合わせ内容が201文字であれば登録×' do
        contact.message = SecureRandom.alphanumeric(201)
        is_expected.to eq false
      end
    end
  end
end
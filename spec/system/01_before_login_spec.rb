require 'rails_helper'

describe '[01]ユーザーログイン前テスト' do
  describe '[01-1]Top画面のテスト' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/'
      end
      it '新規登録リンクが表示され、左から1番目のボタンが「新規登録」である' do
        sign_up_link = find_all('a')[0].native.inner_text
        expect(sign_up_link).to match("新規登録")
      end
      it '新規登録リンクの内容が正しい' do
        sign_up_link = find_all('a')[0].native.inner_text
        expect(page).to have_link sign_up_link, href: new_user_registration_path
      end
      it 'ログインリンクが表示され、左から2番目のボタンが「ログイン」である' do
        sign_in_link = find_all('a')[1].native.inner_text
        expect(sign_in_link).to match("ログイン")
      end
      it 'ログインリンクの内容が正しい' do
        sign_in_link = find_all('a')[1].native.inner_text
        expect(page).to have_link sign_in_link, href: new_user_session_path
      end
      it 'ゲストログインリンクが表示され、左から3番目のボタンが「ゲストログイン」である' do
        guest_sign_in_link = find_all('a')[2].native.inner_text
        expect(guest_sign_in_link).to match("ゲストログイン")
      end
      it 'ゲストログインリンクの内容が正しい' do
        guest_sign_in_link = find_all('a')[2].native.inner_text
        expect(page).to have_link guest_sign_in_link, href: users_guest_sign_in_path
      end
      it 'Aboutリンクが表示され、左から4番目のボタンが「About」である' do
        about_link = find_all('a')[3].native.inner_text
        expect(about_link).to match("About")
      end
      it 'Aboutリンクの内容が正しい' do
        about_link = find_all('a')[3].native.inner_text
        expect(page).to have_link about_link, href: about_path
      end
    end
  end

  describe '[01-2]About画面のテスト' do
    before do
      visit about_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/about'
      end
    end
  end
end
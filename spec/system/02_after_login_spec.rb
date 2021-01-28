require 'rails_helper'
describe '[02]ユーザーログイン後テスト' do
  describe '[02-1]Top画面のテスト' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
      visit root_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/'
      end
      it '「[ユーザー名]さん、お帰りなさい」という文章が存在する' do
        expect(page).to have_content user.name + 'さん、お帰りなさい。'
      end
      it 'マイページリンクの内容が正しい' do
        mypage_link = find_all('a')[0].native.inner_text
        expect(page).to have_link mypage_link, href: user_path(user.id)
      end
      it '投稿一覧リンクが表示され、左から2番目のボタンが「投稿一覧」である' do
        post_index_link = find_all('a')[1].native.inner_text
        expect(post_index_link).to match("投稿一覧")
      end
      it '投稿一覧リンクの内容が正しい' do
        post_index_link = find_all('a')[1].native.inner_text
        expect(page).to have_link post_index_link, href: posts_path
      end
      it '新規投稿リンクが表示され、左から3番目のボタンが「新規投稿」である' do
        post_new_link = find_all('a')[2].native.inner_text
        expect(post_new_link).to match("新規投稿")
      end
      it '新規投稿リンクの内容が正しい' do
        post_new_link = find_all('a')[2].native.inner_text
        expect(page).to have_link post_new_link, href: new_post_path
      end
      it 'ログアウトリンクが表示され、左から4番目のボタンが「ログアウト」である' do
        sign_out_link = find_all('a')[3].native.inner_text
        expect(sign_out_link).to match("ログアウト")
      end
      it 'ログアウトリンクの内容が正しい' do
        sign_out_link = find_all('a')[3].native.inner_text
        expect(page).to have_link sign_out_link, href: destroy_user_session_path
      end
    end
  end
  describe '[02-2]上部ヘッダーのテスト(ログイン後)' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
    end

    context '表示内容の確認' do
      it 'ロゴが表示され、logoクラスを持った画像として存在する' do
        expect(page).to have_css("img[class*='logo']")
      end
      it 'マイページリンクが表示され、左から1番目のボタンが「マイページ」である' do
        mypage_link = find_all('a')[1].native.inner_text
        expect(mypage_link).to match("マイページ")
      end
      it '投稿一覧リンクが表示され、左から2番目のボタンが「投稿一覧」である' do
        post_index_link = find_all('a')[2].native.inner_text
        expect(post_index_link).to match("投稿一覧")
      end
      it '新規投稿リンクが表示され、左から3番目のボタンが「新規投稿」である' do
        post_new_link = find_all('a')[3].native.inner_text
        expect(post_new_link).to match("新規投稿")
      end
      it 'ログアウトリンクが表示され、左から4番目のボタンが「ログアウト」である' do
        sign_out_link = find_all('a')[4].native.inner_text
        expect(sign_out_link).to match("ログアウト")
      end
      it '問い合わせリンクが表示され、左から5番目のボタンが「問い合わせ」である' do
        contact_link = find_all('a')[5].native.inner_text
        expect(contact_link).to match("問い合わせ")
      end
    end
    context 'リンク内容の確認' do
      subject { current_path }

      it 'ロゴを押すと、Top画面に遷移する' do
        top_link = find_all('a')[0].native.inner_text
        top_link = top_link.delete(' ')
        top_link.gsub!(/\n/, '')
        click_link top_link
        is_expected.to eq '/'
      end
      it 'マイページボタンを押すと、マイページ画面に遷移する' do
        mypage_link = find_all('a')[1].native.inner_text
        mypage_link = mypage_link.delete(' ')
        mypage_link.gsub!(/\n/, '')
        click_link mypage_link
        is_expected.to eq '/users/' + User.last.id.to_s
      end
      it '投稿一覧ボタンを押すと、投稿一覧画面に遷移する' do
        post_index_link = find_all('a')[2].native.inner_text
        post_index_link = post_index_link.delete(' ')
        post_index_link.gsub!(/\n/, '')
        click_link post_index_link
        is_expected.to eq '/posts'
      end
      it '新規投稿を押すと、ログイン画面に遷移する' do
        post_new_link = find_all('a')[3].native.inner_text
        post_new_link = post_new_link.delete(' ')
        post_new_link.gsub!(/\n/, '')
        click_link post_new_link
        is_expected.to eq '/posts/new'
      end
      it 'ログアウトボタンを押すと、Top画面に遷移する' do
        sign_out_link = find_all('a')[4].native.inner_text
        sign_out_link = sign_out_link.delete(' ')
        sign_out_link.gsub!(/\n/, '')
        click_link sign_out_link
        is_expected.to eq '/'
      end
      it '問い合わせボタンを押すと、問い合わせ画面に遷移する' do
        contact_link = find_all('a')[5].native.inner_text
        contact_link = contact_link.delete(' ')
        contact_link.gsub!(/\n/, '')
        click_link contact_link
        is_expected.to eq '/contacts/new'
      end
    end
  end
  describe '[02-3]下部ヘッダーのテスト(ログイン後)' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
    end
    context '表示内容の確認' do
      it '「[ユーザー名]さん、ようこそ！」という文章が存在する' do
        expect(page).to have_content user.name + 'さん、ようこそ！'
      end
      it '「つぶやいてみる」フォームが表示される' do
        expect(page).to have_field 'murmur[body]'
      end
      it '「つぶやき送信」ペンボタンが表示される' do
        expect(find("#create_murmur")).to have_selector '.fa-pen-nib'
      end
    end
  end
  describe '[02-4]投稿一覧表示テスト' do
    let(:user) { create(:user) }
    let!(:other_user) { create(:user) }
    let!(:post) { create(:post, user: user) }
    let!(:other_post) { create(:post, user: other_user) }

    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
      visit posts_path
    end
    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/posts'
      end
      it 'タイトル「投稿一覧」が表示される' do
        title = find_all('h2.mt-3')[0].native.inner_text
        expect(title).to match("投　稿　一　覧")
      end
      it '自分と他者の投稿それぞれのユーザーリンク先が正しい' do
        expect(page).to have_link '', href: user_path(post.user)
        expect(page).to have_link '', href: user_path(other_post.user)
      end
      it '自分の他者の投稿のタイトルのリンク先がそれぞれ投稿詳細になっている' do
        expect(page).to have_link post.title, href: post_path(post)
        expect(page).to have_link other_post.title, href: post_path(other_post)
      end
    end
  end
end
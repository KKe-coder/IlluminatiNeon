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

  describe '[01-3]上部ヘッダーのテスト' do
    before do
      visit new_user_registration_path
    end

    context '表示内容の確認' do
      it 'ロゴが表示され、logoクラスを持った画像として存在する' do
        expect(page).to have_css("img[class*='logo']")
      end
      it '新規登録リンクが表示され、左から1番目のボタンが「新規登録」である' do
        sign_up_link = find_all('a')[1].native.inner_text
        expect(sign_up_link).to match("新規登録")
      end
      it 'ログインリンクが表示され、左から2番目のボタンが「ログイン」である' do
        sign_in_link = find_all('a')[2].native.inner_text
        expect(sign_in_link).to match("ログイン")
      end
      it '投稿一覧リンクが表示され、左から3番目のボタンが「投稿一覧」である' do
        post_index_link = find_all('a')[3].native.inner_text
        expect(post_index_link).to match("投稿一覧")
      end
      it 'Aboutリンクが表示され、左から4番目のボタンが「About」である' do
        about_link = find_all('a')[4].native.inner_text
        expect(about_link).to match("About")
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
      it '新規登録ボタンを押すと、新規登録画面に遷移する' do
        sign_up_link = find_all('a')[1].native.inner_text
        sign_up_link = sign_up_link.delete(' ')
        sign_up_link.gsub!(/\n/, '')
        click_link sign_up_link, match: :first
        is_expected.to eq '/users/sign_up'
      end
      it 'ログインボタンを押すと、ログイン画面に遷移する' do
        sign_in_link = find_all('a')[2].native.inner_text
        sign_in_link = sign_in_link.delete(' ')
        sign_in_link.gsub!(/\n/, '')
        click_link sign_in_link, match: :first
        is_expected.to eq '/users/sign_in'
      end
      it '投稿一覧ボタンを押すと、投稿一覧画面に遷移する' do
        post_index_link = find_all('a')[3].native.inner_text
        post_index_link = post_index_link.delete(' ')
        post_index_link.gsub!(/\n/, '')
        click_link post_index_link
        is_expected.to eq '/posts'
      end
      it 'Aboutボタンを押すと、About画面に遷移する' do
        about_link = find_all('a')[4].native.inner_text
        about_link = about_link.delete(' ')
        about_link.gsub!(/\n/, '')
        click_link about_link
        is_expected.to eq '/about'
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
  describe '[01-4]下部ヘッダーのテスト' do
    before do
      visit new_user_registration_path
    end
    context '表示内容の確認' do
      it '1行目の文字列が「IlluminatioNeoNにようこそ！～」となっており正しいこと' do
        no_login_headerobj1 = find_all('p')[0].native.inner_text
        expect(no_login_headerobj1).to match("IlluminatioNeoNにようこそ！美しいイルミネーションと、幻惑的なネオンを共有するサイトです。")
      end
      it '2行目の文字列が「閲覧はログインせずに行えますが、～」と正しいこと' do
        no_login_headerobj2 = find_all('p')[1].native.inner_text
        expect(no_login_headerobj2).to match("閲覧はログインせずに行えますが、投稿やレビュー等にはログインや新規登録が必要になります。")
      end
    end
    context 'リンク内容の確認' do
      subject { current_path }
      it '2行目の文字列内「ログイン」リンクより、ログインページに遷移できること' do
        sign_in_link = find_all('a')[6].native.inner_text
        sign_in_link = sign_in_link.delete(' ')
        sign_in_link.gsub!(/\n/, '')
        click_link sign_in_link, match: :first
        is_expected.to eq '/users/sign_in'
      end
      it '2行目の文字列内「新規登録」リンクより、新規登録ページに遷移できること' do
        sign_up_link = find_all('a')[7].native.inner_text
        sign_up_link = sign_up_link.delete(' ')
        sign_up_link.gsub!(/\n/, '')
        click_link sign_up_link, match: :first
        is_expected.to eq '/users/sign_up'
      end
    end
  end
  describe '[01-5]左右カラムのテスト' do
    let(:user) { create(:user) }
    let!(:post1) { create(:post, user: user, avgrate: 4.5) }
    let!(:post2) { create(:post, user: user, avgrate: 4.7, title: "AVGTOP1") }
    let!(:post3) { create(:post, user: user, avgrate: 4) }
    let!(:post4) { create(:post, user: user) }
    let!(:post5) { create(:post, user: user) }
    let!(:post6) { create(:post, user: user, title: "CRETOP1") }
    before do
      visit new_user_registration_path
    end
    context '表示内容の確認' do
      it '左側に「人気投稿」とタイトルの付いた見出しがあること' do
        expect(page).to have_content '人気投稿'
      end
      it '左カラム最上部(カラム1番目)は、平均評価が最も高いものとなっていること' do
        avgtop_columnpost = find_all('a.column-post-title')[0].native.inner_text
        expect(avgtop_columnpost).to match("AVGTOP1")
      end
      it '右側に「最新投稿」とタイトルの付いた見出しがあること' do
        expect(page).to have_content '最新投稿'
      end
      it '右カラム最上部(カラム4番目)は、投稿日時が最も新しいものとなっていること' do
        createtop_columnpost = find_all('a.column-post-title')[3].native.inner_text
        expect(createtop_columnpost).to match("CRETOP1")
      end
    end
    context 'リンク内容の確認' do
      subject { current_path }

      it '投稿リンクを押すと、投稿詳細に遷移する' do
        columnpost = find_all('a.column-post-title')[0].native.inner_text
        columnpost = columnpost.delete(' ')
        columnpost.gsub!(/\n/, '')
        click_link columnpost
        is_expected.to match(/posts/i)
      end
      it '人物名を押すと、ユーザー詳細に遷移する' do
        columnuser = find_all('a.posts-creater')[0].native.inner_text
        columnuser = columnuser.delete(' ')
        columnuser.gsub!(/\n/, '')
        click_link columnuser, match: :first
        is_expected.to match(/users/i)
      end
    end
  end
  describe '[01-6]ユーザー新規登録のテスト' do
    before do
      visit new_user_registration_path
    end
    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/sign_up'
      end
      it 'タイトル部「新規会員登録」と表示される' do
        expect(page).to have_content '新規会員登録'
      end
      it '「ユーザーネーム(6文字以内)」フォームが表示される' do
        expect(page).to have_field 'user[name]'
      end
      it '「メールアドレス」フォームが表示される' do
        expect(page).to have_field 'user[email]'
      end
      it '「お住まいの都道府県」プルダウンメニューが表示される' do
        expect(page).to have_field 'user[residence]'
      end
      it '「パスワード(6文字以上)」フォームが表示される' do
        expect(page).to have_field 'user[password]'
      end
      it '「パスワード(再入力)」フォームが表示される' do
        expect(page).to have_field 'user[password_confirmation]'
      end
      it '会員登録ボタンが表示される' do
        expect(page).to have_button '会員登録'
      end
    end
    context '新規会員登録のテスト' do
      before do
        fill_in 'user[name]', with: SecureRandom.alphanumeric(6)
        fill_in 'user[email]', with: Faker::Internet.email
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
      end

      it '正しく新規登録される' do
        expect { click_button '会員登録' }.to change(User.all, :count).by(1)
      end
      it '新規登録後のリダイレクト先が、新規登録できたユーザーの詳細画面になっている' do
        click_button '会員登録'
        expect(current_path).to eq '/users/' + User.last.id.to_s
      end
    end
  end
end
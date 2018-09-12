require 'rails_helper'

RSpec.describe 'ログアウト', type: :request do
  include SessionsHelper
  # ログイン状態にしておく
  before do
    @user = FactoryBot.create(:user)
    post login_path, params: { session: user_info }
  end
  let(:user_info) { { email: @user.email, password: @user.password } }
  subject { delete logout_path }
  describe 'ログアウトした場合' do
    it '正しくリダイレクトされている' do
      subject
      expect(response).to redirect_to root_path
    end
    it 'ログイン状態ではない' do
      subject
      follow_redirect!
      # セッションとクッキーが削除されたことを確認しログアウトの確認とした。
      expect(session['user_id']).to be_falsey
      expect(@response.cookies['remember_token']).to be_falsey
      expect(@response.cookies['user_id']).to be_falsey
    end
    it 'ログアウトを複数要求する' do
      subject
      follow_redirect!
      subject
      expect(response).to render_template('static_pages/home')
    end
    it 'ヘッダーのリンクが変更されている' do
      subject
      follow_redirect!
      expect(response.body).to include login_path
      expect(response.body).to_not include logout_path
      expect(response.body).to_not include user_path(@user)
    end
  end
end

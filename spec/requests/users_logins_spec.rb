require 'rails_helper'

RSpec.describe 'ログイン', type: :request do
  before do
    @user = FactoryBot.create(:user)
  end
  subject { post login_path, params: { session: user_info } }
  describe '有効な場合' do
    let(:user_info) { { email: @user.email, password: @user.password, remember_me: '1' } }
    context '正しいログイン情報の場合' do
      it '正しくリダイレクトされている' do
        subject
        expect(response).to redirect_to @user
      end
      it 'users/showが表示されている' do
        subject
        follow_redirect!
        expect(response).to render_template('users/show')
      end
      it 'ヘッダーのリンクが変更されている' do
        subject
        follow_redirect!
        expect(response.body).to_not include login_path
        expect(response.body).to include logout_path
        expect(response.body).to include user_path(@user)
      end
      it 'rememberを使用できる' do
        subject
        expect(@response.cookies['remember_token']).to be_truthy
      end
      it 'rememberのチェックが入っていないときはクッキーを削除' do
        user_info[:remember_me] = '0'
        subject
        expect(@response.cookies['remember_me']).to be_falsey
      end
    end
  end
  describe '無効な場合' do
    let(:user_info) { { email: '', password: '' } }
    context 'ログイン情報が間違っている場合' do
      it 'sessions/newが表示されている' do
        subject
        expect(response).to render_template(:new)
      end
      it 'flashが表示され消える' do
        subject
        expect(response.body).to include 'alert alert-danger'
        get root_path
        expect(response.body).to_not include 'alert alert-danger'
      end
    end
  end
end

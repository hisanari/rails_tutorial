require 'rails_helper'

RSpec.describe "UserEdits", type: :request do
  before do
    @user = FactoryBot.create(:user)
  end

  describe 'ログインしていないとき' do
    it 'editにアクセスするとリダイレクト' do
      get edit_user_path(@user)
      expect(response).to redirect_to login_path
      follow_redirect!
      expect(response.body).to include 'alert alert-danger'
    end
    it 'updateにアクセするとリダイレクト' do
      patch user_path(@user), params: { name: @user.name, email: @user.email }
      expect(response).to redirect_to login_path
      follow_redirect!
      expect(response.body).to include 'alert alert-danger'
    end
  end

  describe 'ログインしている時' do
    let(:user_info) { { email: @user.email, password: @user.password } }
    subject { patch user_path(@user), params: { user: update_user } }

    before do
      post login_path, params: { session: user_info }
    end

    context '共通' do
      it 'users/editが表示されている' do
        get edit_user_path(@user)
        expect(response).to render_template('users/edit')
      end
    end

    context '成功したとき' do
      # 正しい情報
      let(:update_name) { 'fffffff' }
      let(:update_email) { 'fffff@example.com'}
      let(:update_user) { FactoryBot.attributes_for(:user, name: update_name, email: update_email ) }
      it '正しくリダイレクトされている' do
        subject
        expect(response).to redirect_to @user
      end
      it 'ユーザー情報が変更されている' do
        subject
        @user.reload
        expect(@user.name).to eq(update_name)
        expect(@user.email).to eq(update_email)
      end
      it 'flashが表示されている' do
        subject
        follow_redirect!
        expect(response.body).to include 'alert alert-success'
      end
    end
    context '失敗したとき' do
      # 間違っている情報
      let(:update_user) { FactoryBot.attributes_for(:user, name: '') }
      it 'users/editが表示されている' do
        subject
        expect(response).to render_template('users/edit')
      end
      it 'エラーメッセージが表示されてる' do
        subject
        expect(response.body).to include 'error_explanation'
        expect(response.body).to include 'field_with_errors'
      end
    end
  end
end

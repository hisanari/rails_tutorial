require 'rails_helper'

RSpec.describe 'UsersSignups', type: :request do
  describe 'POST /users_signups' do
    subject { post users_path, params: { user: user } }
    describe '成功したとき' do
      include SessionsHelper
      # 正しいユーザー
      let(:user) { FactoryBot.attributes_for(:user) }
      it 'ユーザーが追加されている' do
        expect { subject }.to change(User, :count).by(1)
      end
      it 'showが表示されている' do
        subject
        follow_redirect!
        expect(response).to render_template(:show)
      end
      it 'flashが表示されている' do
        subject
        expect(flash[:success]).to_not be_empty
      end
      it 'ログイン状態になっている' do
        subject
        follow_redirect!
        expect(logged_in?).to be_truthy
      end
    end
    describe '失敗したとき' do
      # エラーになるユーザー
      let(:user) { FactoryBot.attributes_for(:user, name: '') }
      it 'ユーザー追加されていない' do
        expect { subject }.to_not change(User, :count) # 変更されていない
      end
      it 'newが表示されている' do
        subject
        expect(response).to render_template(:new)
      end
      it 'エラーメッセージが表示されてる' do
        subject
        expect(response.body).to include 'error_explanation'
        expect(response.body).to include 'field_with_errors'
        expect(response.body).to include 'action="/signup"'
      end
    end
  end
end

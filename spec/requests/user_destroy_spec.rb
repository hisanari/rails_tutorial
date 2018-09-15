require 'rails_helper'

RSpec.describe 'UserDestroy', type: :request do
  subject { delete user_path(@user) }
  before do
    @non_admin_user = FactoryBot.create(:other)
    @user = FactoryBot.create(:anonymous)
  end
  describe 'ログイン時' do
    before do
      post login_path, params: { session: { email: 'other@example.com', password: 'hogehoge' } }
    end
    it '管理者でなければ他ユーザーを削除できない' do
      expect { subject }.to_not change(User, :count)
    end
  end

  describe '未ログイン時' do
    it '削除できない' do
      expect { subject }.to_not change(User, :count)
    end    
  end
end
require 'rails_helper'

RSpec.describe "userIndexPapages", type: :request do
  before do
    @user = FactoryBot.create(:user)
    30.times { FactoryBot.create(:anonymous) }
  end

  describe 'ログインしている時' do

    before do
      post login_path, params: { session: user_info }
    end
    let(:users) { User.paginate(page: 1) }
    let(:user_info) { { email: @user.email, password: @user.password }}
    it 'indexにindexが表示されている' do
      get users_path
      expect(response).to render_template('users/index')
    end
    it 'ユーザー一覧が表示されている' do
      get users_path
      users.each do |user|
        assert_select 'a[href=?]', user_path(user), text: user.name 
        unless @user == user
          assert_select 'a[href=?]', user_path(user), text: 'delete'
        end
      end
      expect(response.body).to include 'pagination'
    end
  end

  describe 'ログインしていない時' do
    it '正しくリダイレクトされる' do
      get users_path
      expect(response).to redirect_to login_url
    end
  end
end
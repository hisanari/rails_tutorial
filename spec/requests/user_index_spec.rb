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

    let(:user_info) { { email: @user.email, password: @user.password }}
    it 'indexに正しく表示されている' do
      get users_path
      expect(response).to render_template('users/index')
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
require 'rails_helper'

RSpec.describe "userIndexPapages", type: :request do
  before do
    @user = FactoryBot.create(:user)
  end

  describe 'ログインしていない時' do
    it '正しくリダイレクトされる' do
      get users_path
      expect(response).to redirect_to login_url
    end
    
  end
end
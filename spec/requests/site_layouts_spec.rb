require 'rails_helper'

RSpec.describe "SiteLayouts", type: :request do
  include ApplicationHelper
  describe "GET /home" do
    it "layout links" do
      get root_path
      expect(response).to render_template(:home)
      assert_select "a[href=?]", root_path, count: 2
      assert_select "a[href=?]", help_path
      assert_select "a[href=?]", about_path
      assert_select "a[href=?]", contact_path
    end
  end

  describe 'GET /contact' do
    it 'タイトルが正しく設定せれている' do
      get contact_path
      assert_select "title", full_title("Contact")
    end
  end

  describe 'GET /signup' do
    it 'タイトルが正しく設定せれている' do
      get signup_path
      assert_select "title", full_title("Sign up")
    end
  end
end

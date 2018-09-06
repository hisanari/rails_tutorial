require 'rails_helper'

RSpec.describe 'applicationHelper', type: :helper do
  include ApplicationHelper
  describe 'full_title_helper' do
    context '引数がない時' do      
      it 'デフォルトのタイトルを返すこと' do
        expect(full_title).to eql("Ruby on Rails Tutorial Sample App")
      end
    end
    
    context '引数がある場合' do
      it '引数が正しく追加されたタイトルを返すこと' do
        expect(full_title("Home")).to eql("Home | Ruby on Rails Tutorial Sample App")
      end
    end
  end
end
require 'rails_helper'

RSpec.describe 'applicationHelper', type: :helper do
  include ApplicationHelper
  
  it 'full_title_helper 引数無し' do
    expect(full_title).to eql("Ruby on Rails Tutorial Sample App")
  end

  it 'full_title_helper 引数あり' do
    expect(full_title("Home")).to eql("Home | Ruby on Rails Tutorial Sample App")
  end
end
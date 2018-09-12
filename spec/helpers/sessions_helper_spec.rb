require 'rails_helper'

RSpec.describe SessionsHelper, type: :helper do
  let(:user) { FactoryBot.create(:user) }
  before do
    remember(user)
  end
  it 'current_user関数はセッションがnilの時に正しいユーザーを返す' do
    expect(user).to eq(current_user)
    expect(logged_in?).to be_truthy
  end
  it 'remember_digestが間違っているときはcurrent_userはnil' do
    user.update_attribute(:remember_digest, User.digest(User.new_token))
    expect(current_user).to eq(nil)
  end
end

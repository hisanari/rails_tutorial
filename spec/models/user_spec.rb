require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'new' do
    let(:user) { User.new(params) }
    let(:params) { {name: "test", email: "test@example.com"} }
    context '有効な場合' do
      it '有効' do
        expect(user.valid?).to eq(true)
      end      
      it '正しいメールフォーマット' do
        valid_mails = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
          first.last@foo.jp alice+bob@baz.cn]
        valid_mails.each do | mail |
          user.email = mail
          expect(user.valid?).to eq(true)
        end
      end
      it 'メールアドレスは小文字で保存されている' do
        mix_case_mail = "Foo@ExAMPle.CoM"
        user.email = mix_case_mail
        user.save
        expect(mix_case_mail.downcase).to eq(user.reload.email)
      end
    end
    context '無効な場合' do
      it '名前がない' do
        user.name = ' '
        expect(user.valid?).to eq(false)
      end
      it 'メールアドレスがない' do
        user.email = ' '
        expect(user.valid?).to eq(false)
      end
      it '名前が長すぎる' do
        user.name = "a" * 51
        expect(user.valid?).to eq(false)
      end
      it 'アドレスが長すぎる' do
        user.email = "a" * 244 + "@example.com"
        expect(user.valid?).to eq(false)
      end
      it '正しくないメールフォーマット' do
        invalid_mails = %w[user@example,com user_at_foo.org user.name@example.
          foo@bar_baz.com foo@bar+baz.com test@bar..com]
        invalid_mails.each do | mail |
          user.email = mail
          expect(user.valid?).to eq(false), "#{mail}"
         end
      end
      it 'ユニークなアドレスではない' do
        dup_user = user.dup
        dup_user.email.upcase!
        user.save
        expect(dup_user.valid?).to eq(false)
      end
    end
  end
end

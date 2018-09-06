class User < ApplicationRecord
  # saveの前に処理を挟み込む
  before_save { email.downcase! }
  # メールアドレスのフォーマットをチェックするための正規表現
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  # presence 存在の確認
  # length 長さの上限
  # format 正しいフォーマット
  validates :name, presence: true, length: { maximum: 50 }
  validates :email,
    presence: true,
    length: { maximum: 255 },
    format: { with: VALID_EMAIL_REGEX },
    uniqueness: { case_sensitive: false }
end

class User < ApplicationRecord
  attr_accessor :remember_token
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
  # パスワードを安全に保存するために必要なものを使用できるようになる
  has_secure_password
  # パスワードの存在性、長さのバリデーション
  validates :password, presence: true, length: { minimum: 6 }

  # 文字列のハッシュを返す
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # ランダムなトークンを返す（記憶トークン）
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # 永続セッションのためにユーザーをDBに記憶する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # 渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # ログイン情報を破棄
  def forget
    update_attribute(:remember_digest, nil)
  end
end

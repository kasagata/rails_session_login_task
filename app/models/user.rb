class User < ApplicationRecord
    has_many :tasks
    has_secure_password
    validates :password, presence: {message: 'パスワードを入力してください'}, length: { minimum: 6, too_short: 'パスワードは6文字以上で入力してください'}, confirmation: {message: 'パスワード（確認）とパスワードの入力が一致しません'}
    validates :name, presence: {message: '名前を入力してください'}, length: { maximum: 30 }
    validates :email, presence: {message: 'メールアドレスを入力してください'}, length: { maximum: 255 }, uniqueness: {message: 'メールアドレスはすでに使用されています'}, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
    before_validation { email.downcase! }
end
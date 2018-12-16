class User < ApplicationRecord
  has_secure_password
  has_secure_token

  validates :username,
    presence: true,
    uniqueness: true,
    length: { maximum: 16 },
    format: {
      with: /\A[a-zA-Z0-9]+\z/,
      message: 'は小文字英数字で入力してください'
    }
  validates :password,
    length: { minimum: 4 }
  validates :token,
    uniqueness: true
end

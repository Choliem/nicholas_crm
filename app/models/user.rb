class User < ApplicationRecord
  # Baris di bawah ini yang mengubah 'password' menjadi 'password_digest' secara otomatis
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :role, presence: true
end
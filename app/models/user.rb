class User < ApplicationRecord
  has_secure_password
  
  default_scope { where(deleted_at: nil) }

  has_many :projects

  validates :email, presence: true, uniqueness: { scope: :deleted_at }
  validates :role, presence: true

  def soft_delete
    update(deleted_at: Time.current)
  end
end
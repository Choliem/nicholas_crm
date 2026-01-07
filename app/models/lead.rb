class Lead < ApplicationRecord
  default_scope { where(deleted_at: nil) }

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { scope: :deleted_at }, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone, presence: true, uniqueness: { scope: :deleted_at }

  has_many :projects

  def soft_delete
    update(deleted_at: Time.current)
  end

  def recover
    update(deleted_at: nil)
  end
end

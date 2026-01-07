class Product < ApplicationRecord
  default_scope { where(deleted_at: nil) }

  validates :name, presence: true
  validates :price, numericality: { greater_than: 0 }

  has_many :projects

  def soft_delete
    update(deleted_at: Time.current)
  end
end

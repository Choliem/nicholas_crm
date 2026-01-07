class Project < ApplicationRecord
  belongs_to :lead
  belongs_to :product
  belongs_to :user
end

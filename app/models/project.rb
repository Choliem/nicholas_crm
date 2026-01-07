class Project < ApplicationRecord
  belongs_to :lead
  belongs_to :product
end

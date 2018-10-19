class Job < ApplicationRecord
  has_many :invoices
  belongs_to :user
  belongs_to :load
end

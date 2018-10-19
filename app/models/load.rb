class Load < ApplicationRecord
  has_many :jobs
  has_many :packages
  belongs_to :user
end

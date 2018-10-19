class User < ApplicationRecord
  has_many :jobs
  has_many :loads
  has_many :user_vehicles
end

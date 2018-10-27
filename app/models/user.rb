class User < ApplicationRecord
  has_many :jobs
  has_many :loads
  has_many :user_vehicles
  has_many :big_vehicles, -> { where('capacity > 10000') }, through: :user_vehicles, source: :vehicle
end

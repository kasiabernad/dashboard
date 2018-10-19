class Package < ApplicationRecord
  belongs_to :load, optional: true
end

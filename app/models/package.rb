class Package < ApplicationRecord
  belongs_to :load, optional: true

  enum kind: %i[liquid, box, pallette, material]
end

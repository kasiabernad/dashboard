class CreateLoadCreatorDrivers < ActiveRecord::Migration[5.2]
  def change
    create_view :load_creator_drivers, materialized: true
  end
end

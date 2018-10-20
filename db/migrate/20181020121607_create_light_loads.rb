class CreateLightLoads < ActiveRecord::Migration[5.2]
  def change
    create_view :light_loads, materialized: true
  end
end

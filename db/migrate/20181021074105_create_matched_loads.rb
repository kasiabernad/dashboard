class CreateMatchedLoads < ActiveRecord::Migration[5.2]
  def change
    create_view :matched_loads, materialized: true
  end
end

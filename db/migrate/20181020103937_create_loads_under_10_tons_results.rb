class CreateLoadsUnder10TonsResults < ActiveRecord::Migration[5.2]
  def change
    create_view :loads_under_10_tons_results
  end
end

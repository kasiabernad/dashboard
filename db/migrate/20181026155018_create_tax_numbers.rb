class CreateTaxNumbers < ActiveRecord::Migration[5.2]
  def change
    create_view :tax_numbers, materialized: true
  end
end

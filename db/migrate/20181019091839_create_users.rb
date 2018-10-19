class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :surname
      t.string :tax_number
      t.string :address
      
      t.references :load
      t.references :job
      t.timestamps
    end
  end
end

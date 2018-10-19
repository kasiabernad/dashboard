class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :surname
      t.string :tax_number
      t.string :address

      t.timestamps
    end
  end
end

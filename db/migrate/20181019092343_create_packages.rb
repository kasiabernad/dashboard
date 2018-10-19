class CreatePackages < ActiveRecord::Migration[5.2]
  def change
    create_table :packages do |t|
      t.integer :amount
      t.integer :type
      t.references :load
      
      t.timestamps
    end
  end
end

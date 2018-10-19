class CreateInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices do |t|
      t.float :price
      t.string :buyer_tax_number
      t.string :buyer_name
      t.string :buyer_address

      t.references :job
      t.timestamps
    end
  end
end

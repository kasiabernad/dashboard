class CreateLoads < ActiveRecord::Migration[5.2]
  def change
    create_table :loads do |t|
      t.integer :weight
      t.string :start_location
      t.string :end_location
      t.datetime :start_date
      t.datetime :end_date

      t.references :user
      t.timestamps
    end
  end
end

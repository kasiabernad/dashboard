class CreateUserVehicles < ActiveRecord::Migration[5.2]
  def change
    create_table :user_vehicles do |t|
      t.string :plate_number
      t.references :user
      t.references :vehicle

      t.timestamps
    end
  end
end

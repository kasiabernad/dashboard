class CreateJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :jobs do |t|
      t.references :load
      t.references :user
      
      t.timestamps
    end
  end
end

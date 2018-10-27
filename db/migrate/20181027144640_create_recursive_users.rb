class CreateRecursiveUsers < ActiveRecord::Migration[5.2]
  def change
    create_view :recursive_users, materialized: true
  end
end

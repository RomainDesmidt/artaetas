class DropOrders < ActiveRecord::Migration
  def up
    drop_table :orders
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
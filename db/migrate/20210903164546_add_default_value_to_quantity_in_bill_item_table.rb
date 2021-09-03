class AddDefaultValueToQuantityInBillItemTable < ActiveRecord::Migration[6.1]
  def change
    remove_column :bill_items, :quantity
    add_column :bill_items, :quantity, :integer, default: 1
  end
end

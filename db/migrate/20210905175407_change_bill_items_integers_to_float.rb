class ChangeBillItemsIntegersToFloat < ActiveRecord::Migration[6.1]
  def change
    remove_column :bill_items, :price
    remove_column :bill_items, :total
    add_column :bill_items, :price, :float, default: 0.0
    add_column :bill_items, :total, :float, default: 0.0
  end
end

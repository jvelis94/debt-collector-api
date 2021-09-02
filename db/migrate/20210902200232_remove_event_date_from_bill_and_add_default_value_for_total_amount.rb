class RemoveEventDateFromBillAndAddDefaultValueForTotalAmount < ActiveRecord::Migration[6.1]
  def change
    remove_column :bills, :event_date
    remove_column :bills, :total_amount
    add_column :bills, :total_amount, :integer, default: 0
  end
end

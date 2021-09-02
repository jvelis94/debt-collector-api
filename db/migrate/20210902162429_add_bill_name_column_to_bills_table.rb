class AddBillNameColumnToBillsTable < ActiveRecord::Migration[6.1]
  def change
    add_column :bills, :bill_name, :string
  end
end

class RenameIsPaidCOlumn < ActiveRecord::Migration[6.1]
  def change
    remove_column :bill_recipients, :isPaid
    add_column :bill_recipients, :is_paid, :boolean, default: false
  end
end

class ChangeDefaultValuesOfBillRecipients < ActiveRecord::Migration[6.1]
  def change
    remove_column :bill_recipients, :total_owes
    remove_column :bill_recipients, :total_paid
    remove_column :bill_recipients, :tax
    remove_column :bill_recipients, :subtotal
    remove_column :bill_recipients, :gratuity
    add_column :bill_recipients, :total_owes, :integer, default: 0
    add_column :bill_recipients, :total_paid, :integer, default: 0
    add_column :bill_recipients, :tax, :integer, default: 0
    add_column :bill_recipients, :subtotal, :integer, default: 0
    add_column :bill_recipients, :gratuity, :integer, default: 0
  end
end
class ChangeIntegerColumnsToFloat < ActiveRecord::Migration[6.1]
  def change
    remove_column :bills, :total_amount, :total_owes
    remove_column :bills, :subtotal
    remove_column :bills, :tax
    remove_column :bills, :gratuity_amount
    add_column :bills, :total_amount, :float, default: 0.0
    add_column :bills, :subtotal, :float, default: 0.0
    add_column :bills, :tax, :float, default: 0.0
    add_column :bills, :gratuity_amount, :float, default: 0.0
  end
end

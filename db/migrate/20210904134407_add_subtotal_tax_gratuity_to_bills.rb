class AddSubtotalTaxGratuityToBills < ActiveRecord::Migration[6.1]
  def change
    add_column :bills, :subtotal, :integer, default: 0
    add_column :bills, :tax, :integer, default: 0
    add_column :bills, :gratuity, :float, default: 0.18 
  end
end

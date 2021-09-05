class AddGratuityDollarAmountToBill < ActiveRecord::Migration[6.1]
  def change
    add_column :bills, :gratuity_amount, :integer, default: 0
  end
end

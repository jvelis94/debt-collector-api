class AddTaxTipToBillRecipients < ActiveRecord::Migration[6.1]
  def change
    add_column :bill_recipients, :tax, :integer
    add_column :bill_recipients, :subtotal, :integer
    add_column :bill_recipients, :gratuity, :integer
  end
end

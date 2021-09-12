class IsPaidToBillRecipients < ActiveRecord::Migration[6.1]
  def change
    add_column :bill_recipients, :isPaid, :boolean, default: false
  end
end

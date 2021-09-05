class AddTotalToBillItems < ActiveRecord::Migration[6.1]
  def change
    add_column :bill_items, :total, :integer
  end
end

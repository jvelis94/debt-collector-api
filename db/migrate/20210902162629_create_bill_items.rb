class CreateBillItems < ActiveRecord::Migration[6.1]
  def change
    create_table :bill_items do |t|
      t.references :bill, null: false, foreign_key: true
      t.references :bill_recipient, null: false, foreign_key: true
      t.string :item_name
      t.integer :quantity
      t.integer :price

      t.timestamps
    end
  end
end

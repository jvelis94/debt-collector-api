class CreateBillRecipients < ActiveRecord::Migration[6.1]
  def change
    create_table :bill_recipients do |t|
      t.references :bill, null: false, foreign_key: true
      t.string :recipient_name
      t.integer :total_owes
      t.integer :total_paid

      t.timestamps
    end
  end
end

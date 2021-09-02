class CreateBills < ActiveRecord::Migration[6.1]
  def change
    create_table :bills do |t|
      t.datetime :event_date
      t.integer :total_amount
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

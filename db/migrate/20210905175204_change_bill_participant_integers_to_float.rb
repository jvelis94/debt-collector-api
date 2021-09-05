class ChangeBillParticipantIntegersToFloat < ActiveRecord::Migration[6.1]
  def change
    remove_column :bill_recipients, :total_owes
    remove_column :bill_recipients, :total_paid
    remove_column :bill_recipients, :subtotal
    remove_column :bill_recipients, :tax
    remove_column :bill_recipients, :gratuity
    add_column :bill_recipients, :total_owes, :float, default: 0.0
    add_column :bill_recipients, :total_paid, :float, default: 0.0
    add_column :bill_recipients, :subtotal, :float, default: 0.0
    add_column :bill_recipients, :tax, :float, default: 0.0
    add_column :bill_recipients, :gratuity, :float, default: 0.0
  end
end
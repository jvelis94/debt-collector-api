class BillRecipient < ApplicationRecord
  belongs_to :bill
  has_many :bill_items, dependent: :destroy
  has_many :bills, through: :bill_items
end

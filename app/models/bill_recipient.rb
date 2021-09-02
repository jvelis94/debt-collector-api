class BillRecipient < ApplicationRecord
  belongs_to :bill
  has_many :bill_items
  has_many :bills, through: :bill_items
end

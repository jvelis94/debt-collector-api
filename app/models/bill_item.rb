class BillItem < ApplicationRecord
  belongs_to :bill
  belongs_to :bill_recipient
  
end

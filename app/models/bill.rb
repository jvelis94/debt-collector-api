class Bill < ApplicationRecord
  belongs_to :user
  has_many :bill_recipients, dependent: :destroy
  has_many :bill_items, dependent: :destroy
  
end

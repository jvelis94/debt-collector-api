class IncrementBillItem
    def initialize(bill, bill_recipient, bill_item)
        @bill = bill
        @bill_recipient = bill_recipient
        @bill_item = bill_item
    end

    def call
        @bill_item.increment!(:quantity)
        UpdateBillItemTotal.new(@bill_item).call
        UpdateBillAndRecipientValues.new(@bill, @bill_recipient).call
    end

end
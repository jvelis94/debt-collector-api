class UpdateBillAndRecipientValues
    def initialize(bill, bill_recipient)
        @bill = bill
        @bill_recipient = bill_recipient
    end

    def call
        @bill.bill_recipients.each { |bill_recipient| UpdateBillRecipientValues.new(bill_recipient).call }
        bill = UpdateBillValues.new(@bill).call
        return bill
    end

end
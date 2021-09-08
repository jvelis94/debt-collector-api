class UpdateBillAndRecipientValues
    def initialize(bill, bill_recipient)
        @bill = bill
        @bill_recipient = bill_recipient
    end

    def call
        UpdateBillRecipientValues.new(@bill_recipient).call
        UpdateBillValues.new(@bill).call
    end

end
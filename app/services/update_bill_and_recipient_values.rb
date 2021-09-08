class UpdateBillAndRecipientValues
    def initialize(bill, bill_recipient)
        @bill = bill
        @bill_recipient = bill_recipient
    end

    def call
        puts "IN UPDATE BOTH VALUES"
        UpdateBillRecipientValues.new(@bill_recipient).call
        bill = UpdateBillValues.new(@bill).call
        return bill
        
        # return { bill: bill, bill_recipient: bill_recipient }.to_h
        # UpdateBillRecipientValues.new(@bill_recipient).call
        # UpdateBillValues.new(@bill).call
    end

end
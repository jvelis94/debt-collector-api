class UpdateBillRecipientValues
    def initialize(bill_recipient)
        @bill_recipient = bill_recipient
    end

    def call
        @bill_recipient.update!(subtotal: bill_recipient_subtotal, gratuity: bill_recipient_gratuity, total_owes: bill_recipient_total)
    end

    private

    def bill_recipient_subtotal
        @bill_recipient.bill_items.pluck(:total).inject(:+)
    end

    def bill_recipient_gratuity
        bill_recipient_subtotal * @bill_recipient.bill.gratuity
    end

    def bill_recipient_total
        bill_recipient_subtotal + bill_recipient_gratuity
    end

end
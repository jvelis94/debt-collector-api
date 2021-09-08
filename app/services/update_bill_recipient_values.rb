class UpdateBillRecipientValues
    def initialize(bill_recipient)
        @bill_recipient = bill_recipient
    end

    def call
        @bill_recipient.update!(subtotal: bill_recipient_subtotal, gratuity: bill_recipient_gratuity, tax: bill_recipient_tax, total_owes: bill_recipient_total)
    end

    private

    def bill_recipient_subtotal
        @bill_recipient.bill_items.pluck(:total).inject(:+) || 0
    end

    def bill_recipient_gratuity
        bill_recipient_subtotal * @bill_recipient.bill.gratuity
    end

    def bill_recipient_tax
        recipient_share_of_tax = bill_recipient_subtotal / @bill_recipient.bill.bill_items.pluck(:total).inject(:+)
        recipient_tax = @bill_recipient.bill.tax * recipient_share_of_tax
    end

    def bill_recipient_total
        bill_recipient_subtotal + bill_recipient_gratuity + bill_recipient_tax
    end


end
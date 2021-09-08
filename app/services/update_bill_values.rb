class UpdateBillValues
    def initialize(bill)
        @bill = bill
    end

    def call
        puts "IN UPDATE BILL VALUES"
        puts bill_subtotal
        puts bill_gratuity
        puts bill_total
        @bill.update!(subtotal: bill_subtotal, gratuity_amount: bill_gratuity, total_amount: bill_total)
        return @bill
    end

    private

    def bill_subtotal
        @bill.bill_recipients.pluck(:subtotal).inject(:+)
    end

    def bill_gratuity
        bill_subtotal * @bill.gratuity
    end

    def bill_total
        bill_subtotal + bill_gratuity
    end

end
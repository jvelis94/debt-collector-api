class UpdateBillItemTotal
    def initialize(bill_item)
        @bill_item = bill_item
    end

    def call
        @bill_item.update!(total: bill_item_total)
    end

    private

    def bill_item_total
        @bill_item.price * @bill_item.quantity
    end

end
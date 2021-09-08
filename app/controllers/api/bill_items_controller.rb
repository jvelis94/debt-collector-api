class Api::BillItemsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_bill_item, only: [:show, :increment_quantity, :decrement_quantity, :destroy]
    before_action :set_bill, only: [:show, :increment_quantity, :decrement_quantity, :destroy]
    before_action :set_bill_recipient, only: [:show, :increment_quantity, :decrement_quantity, :destroy]

    def create
        @bill_item = BillItem.new(bill_item_params)
        @bill_item = update_bill_item_total(@bill_item)
        if @bill_item.save
            update_bill_and_recipient_values(@bill_item)
            render json: @bill_item.to_json({ include: :bill_recipient })
        else
            render json: { 
                message: "could not add bill item, please try again"
            }.to_json() 
            print !bill_item.errors.full_messages
        end
    end

    def increment_quantity
        @bill_item.increment!(:quantity)
        UpdateBillItemTotal.new(@bill_item).call
        UpdateBillAndRecipientValues.new(@bill, @bill_recipient).call
        render json: @bill_item.to_json({ include: :bill_recipient })
    end

    def decrement_quantity
        @bill_item.decrement!(:quantity)
        UpdateBillItemTotal.new(@bill_item).call
        UpdateBillAndRecipientValues.new(@bill, @bill_recipient).call
        render json: @bill_item.to_json({ include: :bill_recipient })
    end

    def destroy
        @bill_item.destroy
        if @bill.bill_items.count === 0
            @bill.update!(total_amount: 0, subtotal: 0, gratuity_amount: 0)
            @bill.bill_recipients.each { |bill_recipient| bill_recipient.update!(total_owes: 0, subtotal: 0, gratuity: 0) }
        else
            UpdateBillAndRecipientValues.new(@bill, @bill_recipient).call
        end
        render json: @bill_item.to_json({ include: :bill_recipient })
    end

    private


    def bill_item_params
        params.require(:bill_item).permit(:item_name, :quantity, :price, :bill_id, :bill_recipient_id)
    end

    def set_bill_item
        @bill_item = BillItem.find(params[:id])
    end

    def set_bill
        @bill = Bill.find(params[:bill_id])
    end

    def set_bill_recipient
        @bill_recipient = BillRecipient.find_by(bill_id: params[:bill_id])
    end

end

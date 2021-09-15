class Api::BillItemsController < ApplicationController
    # before_action :authenticate_user!
    before_action :set_bill_item, only: [:show, :increment_quantity, :decrement_quantity, :destroy]
    before_action :set_bill
    before_action :set_bill_recipient

    def create
        @bill_item = BillItem.new(bill_item_params)
        if @bill_item.save
            UpdateBillItemTotal.new(@bill_item).call
            bill = UpdateBillAndRecipientValues.new(@bill, @bill_recipient).call
            render json: bill.to_json(include: { bill_recipients: {include: :bill_items} })
        else
            render json: { message: "could not add bill item, please try again" }.to_json() 
            print !bill_item.errors.full_messages
        end
    end

    def increment_quantity
        updated_bill = IncrementBillItem.new(@bill, @bill_recipient, @bill_item).call
        render json: updated_bill.to_json(include: { bill_recipients: {include: :bill_items} })
    end

    def decrement_quantity
        updated_bill = DecrementBillItem.new(@bill, @bill_recipient, @bill_item).call
        render json: updated_bill.to_json(include: { bill_recipients: {include: :bill_items} })
    end

    def destroy
        @bill_item.destroy
        updated_bill = UpdateBillAndRecipientValues.new(@bill, @bill_recipient).call
        render json: updated_bill.to_json(include: { bill_recipients: {include: :bill_items} })
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
        @bill_recipient = BillRecipient.find(params[:bill_recipient_id])
    end

end

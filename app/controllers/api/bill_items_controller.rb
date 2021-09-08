class Api::BillItemsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_bill_item, only: [:show, :increment_quantity, :decrement_quantity, :destroy]
    before_action :set_bill
    before_action :set_bill_recipient

    def create
        puts "IN BILL ITEMS CREATE AGAIN"
        puts @bill_recipient.id
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
        @bill_item.increment!(:quantity)
        UpdateBillItemTotal.new(@bill_item).call
        
        bill = UpdateBillAndRecipientValues.new(@bill, @bill_recipient).call
        render json: bill.to_json(include: { bill_recipients: {include: :bill_items} })
    end

    def decrement_quantity
        @bill_item.decrement!(:quantity)
        UpdateBillItemTotal.new(@bill_item).call
        
        bill = UpdateBillAndRecipientValues.new(@bill, @bill_recipient).call
        render json: bill.to_json(include: { bill_recipients: {include: :bill_items} })
    end

    def destroy
        @bill_item.destroy
        if @bill.bill_items.count === 0
            @bill.update!(total_amount: 0, subtotal: 0, gratuity_amount: 0)
            @bill.bill_recipients.each { |bill_recipient| bill_recipient.update!(total_owes: 0, subtotal: 0, gratuity: 0) }
            render json: @bill.to_json(include: { bill_recipients: {include: :bill_items} })
        else
            bill = UpdateBillAndRecipientValues.new(@bill, @bill_recipient).call
            render json: bill.to_json(include: { bill_recipients: {include: :bill_items} })
        end
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

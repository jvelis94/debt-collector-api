class Api::BillItemsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_bill_item, only: [:show, :increment_quantity, :decrement_quantity, :destroy]

    def create
        @bill_item = BillItem.new(bill_item_params)
        # @bill_item.bill.total_amount += (@bill_item.price)
        # @bill_item.bill_recipient.subtotal += (@bill_item.price)
        if @bill_item.save
            update_bill_values("increment")
            update_bill_recipient_subtotal("increment")
            render json: @bill_item.to_json()
        else
            render json: { 
                message: "could not add bill item, please try again"
            }.to_json() 
            print @bill_item.errors.full_messages
        end
    end

    def increment_quantity
        @bill_item.increment!(:quantity)
        update_bill_values("increment")
        update_bill_recipient_subtotal("increment")
    end

    def decrement_quantity
        @bill_item.decrement!(:quantity)
        update_bill_values("decrement")
        update_bill_recipient_subtotal("decrement")
    end

    def destroy
        @bill_item.destroy
    end

    private

    def update_bill_values(type)
        if type==="increment"
            @bill_item.bill.update_attribute(:total_amount, (@bill_item.bill.total_amount + @bill_item.price))
        else
            @bill_item.bill.update_attribute(:total_amount, (@bill_item.bill.total_amount - @bill_item.price))
        end
    end

    def update_bill_recipient_subtotal(type)
        if type==="increment"
            @bill_item.bill_recipient.update_attribute(:subtotal, (@bill_item.bill_recipient.subtotal + @bill_item.price))
        else
            @bill_item.bill_recipient.update_attribute(:subtotal, (@bill_item.bill_recipient.subtotal - @bill_item.price))
        end
    end

    def bill_item_params
        params.require(:bill_item).permit(:item_name, :quantity, :price, :bill_id, :bill_recipient_id)
    end

    def set_bill_item
        @bill_item = BillItem.find(params[:id])
    end

end

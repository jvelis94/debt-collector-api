class Api::BillItemsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_bill_item, only: [:show, :increment_quantity, :decrement_quantity, :destroy]
    # after_action :update_bill_values
    

    def create
        @bill_item = BillItem.new(bill_item_params)
        if @bill_item.save
            # update_bill_values("increment")
            # update_bill_recipient_subtotal("increment")
            update_bill_and_recipient_values("increment")
            render json: @bill_item.to_json({ include: :bill_recipient })
            # render json: @bill_item.to_json()
        else
            render json: { 
                message: "could not add bill item, please try again"
            }.to_json() 
            print @bill_item.errors.full_messages
        end
    end

    def increment_quantity
        @bill_item.increment!(:quantity)
        update_bill_and_recipient_values("increment")
        # update_bill_values("increment")
        # update_bill_recipient_subtotal("increment")
        render json: @bill_item.to_json({ include: :bill_recipient })
    end

    def decrement_quantity
        @bill_item.decrement!(:quantity)
        update_bill_and_recipient_values("decrement")
        # update_bill_values("decrement")
        # update_bill_recipient_subtotal("decrement")
        render json: @bill_item.to_json({ include: :bill_recipient })
    end

    def destroy
        @bill_item.destroy
    end

    private

    def update_bill_values(type)
        subtotal_action = type === "increment" ? @bill_item.bill.total_amount + @bill_item.price : @bill_item.bill.total_amount - @bill_item.price
        total_action = type === "increment" ? @bill_item.bill.subtotal + @bill_item.price : @bill_item.bill.subtotal - @bill_item.price
        @bill_item.bill.update!(total_amount: total_action, subtotal: subtotal_action)
              
    end

    def update_bill_recipient_values(type)
        subtotal_action = type === "increment" ? @bill_item.bill_recipient.subtotal + @bill_item.price : @bill_item.bill_recipient.subtotal - @bill_item.price
        total_action = type === "increment" ? @bill_item.bill_recipient.total_owes + @bill_item.price : @bill_item.bill_recipient.total_owes - @bill_item.price
        @bill_item.bill_recipient.update!(subtotal: subtotal_action, total_owes: total_action)
    end

    def update_bill_and_recipient_values(type)
        update_bill_values(type)
        update_bill_recipient_values(type)
    end

    def bill_item_params
        params.require(:bill_item).permit(:item_name, :quantity, :price, :bill_id, :bill_recipient_id)
    end

    def set_bill_item
        @bill_item = BillItem.find(params[:id])
    end

end

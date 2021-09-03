class Api::BillRecipientsController < ApplicationController
    before_action :authenticate_user!

    def create
        @bill_recipient = BillRecipient.new(bill_recipient_params)
        bill = Bill.find(params[:bill_id])
        @bill_recipient.bill = bill
        if @bill_recipient.save
            render json: @bill_recipient.to_json()
        else
            render json: { 
                message: "could not add bill recipient, please try again"
            }.to_json() 
            print @bill_recipient.errors.full_messages
        end
    end

    private

    def bill_recipient_params
        params.require(:bill_recipient).permit(:recipient_name, :bill_id)
    end
end

class Api::BillsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_bill, only: [:show]

    respond_to :html, :json

    def create
        @bill = Bill.new(bill_params)
        @bill.user = current_user
        if @bill.save
            render json: @bill.to_json()
        else
            render json: { 
                message: "could not create bill, please try again"
            }.to_json() 
            print @bill.errors.full_messages
        end
    end

    def show
        render json: @bill.to_json()
    end

    private

    def set_bill
        @bill = Bill.find(params[:id])
    end

    def bill_params
        params.require(:bill).permit(:bill_name)
    end

end

class Api::BillsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_bill, only: [:show, :update]

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
        render json: @bill.to_json(include: { bill_recipients: {include: :bill_items} })
    end

    def update
        puts 'updating bill and recipients'
        if params[:tax]
            @bill.update_attribute(:tax, params[:tax])
        elsif params[:gratuity]
            @bill.update_attribute(:gratuity, params[:gratuity])
        else
            @bill.update(bill_params)
        end
        render json: @bill.to_json(include: { bill_recipients: {include: :bill_items} })
    end

    private

    def set_bill
        @bill = Bill.includes(:bill_recipients).find(params[:id])
    end

    def bill_params
        params.require(:bill).permit(:bill_name)
    end

    # def update_tax(tax_param)


    # end

end

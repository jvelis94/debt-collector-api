class Api::BillsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_bill, only: [:show, :update]

    respond_to :html, :json

    def index
        @bills = Bill.where(user: current_user)
        render json: @bills.to_json(include: { bill_recipients: {include: :bill_items} })
    end

    
    def create
        @bill = Bill.new(bill_params)
        @bill.user = current_user
        if @bill.save
            BillMailer.with(bill: @bill).new_bill.deliver_later
            render json: @bill.to_json()
        else
            render json: { message: "could not create bill, please try again"}.to_json() 
            print @bill.errors.full_messages
        end
    end

    def show
        if @bill.user === current_user
            render json: @bill.to_json(include: { bill_recipients: {include: :bill_items} })
        else
            render json: { message: "unauthorized"}.to_json()
        end
    end

    def update
        puts 'updating bill and recipients'
        if params[:tax] || params[:gratuity]
            @bill.update!(tax: params[:tax]) if params[:tax]
            @bill.update!(gratuity: params[:gratuity]) if params[:gratuity]
        else
            @bill.update(bill_params)
        end
        UpdateBillValues.new(@bill).call
        update_recipient_on_gratuity
        render json: @bill.to_json(include: { bill_recipients: {include: :bill_items} })
    end


    def update_recipient_on_gratuity
        @bill.bill_recipients.each do |recipient|
            UpdateBillRecipientValues.new(recipient).call
        end
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

class Api::BillsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_bill, only: [:show, :update]

    respond_to :html, :json
    
    def index
        @bills = Bill.where(user: current_user)
        render json: @bills.to_json()
    end

    
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
        if @bill.user === current_user
            render json: @bill.to_json(include: { bill_recipients: {include: :bill_items} })
        else
            render json: { message: "unauthorized"}.to_json()
        end
    end

    def update
        puts 'updating bill and recipients'
        if params[:tax]
            @bill.update!(tax: params[:tax])
            update_bill_on_gratuity
            update_recipient_on_gratuity
        elsif params[:gratuity]
            @bill.update!(gratuity: params[:gratuity])
            update_bill_on_gratuity
            update_recipient_on_gratuity
        else
            @bill.update(bill_params)
        end
        render json: @bill.to_json(include: { bill_recipients: {include: :bill_items} })
    end

    def update_bill_on_gratuity
        new_gratuity = @bill.gratuity * @bill.subtotal
        bill_total = @bill.subtotal + @bill.tax + new_gratuity
        @bill.update!(total_amount: bill_total, gratuity_amount: new_gratuity)
    end

    def update_recipient_on_gratuity
        @bill.bill_recipients.each do |recipient|
            recipient_share_of_tax = recipient.subtotal / @bill.subtotal
            recipient_tax = @bill.tax * recipient_share_of_tax
            new_recipient_gratuity = @bill.gratuity * recipient.subtotal
            new_recipient_owes = recipient.subtotal + recipient_tax + new_recipient_gratuity
            recipient.update!(gratuity: new_recipient_gratuity, tax: recipient_tax, total_owes: new_recipient_owes)
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

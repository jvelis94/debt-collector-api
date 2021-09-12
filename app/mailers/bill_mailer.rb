class BillMailer < ActionMailer::Base
    def new_bill
        puts "NEW BILL"
        # @user = params[:user]
        # @bill = params[:bill]
        # puts @user.email
        # puts @bill.bill_name
        mail(to: "velisjoel@gmail.com", subject: 'New Bill Created')
    end
end
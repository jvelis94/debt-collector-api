class BillMailer < ActionMailer::Base
    def new_bill
        puts "NEW BILL"
        @bill = params[:bill]
        mail(from: "Split App <split.collector.app@gmail.com>", to: @bill.user.email, subject: "Have you been paid for #{@bill.bill_name} charges?")
    end
end
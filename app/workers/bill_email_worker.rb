class BillEmailWorker
  include Sidekiq::Worker

  def perform(*args)
    open_bills = Bill.joins(:bill_recipients).where("bill_recipients.is_paid is ?", false).uniq
    open_bills.each do |bill|
      BillMailer.with(bill: bill).new_bill.deliver_later
    end
  end
end

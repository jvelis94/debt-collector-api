namespace :bill_email do
  desc "Sends scheduled emails"
  task send_scheduled_bill_email: :environment do 
      BillMailer.new_bill
  end
end

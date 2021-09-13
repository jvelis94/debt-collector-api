namespace :bill_email do 
    desc "Sends scheduled emails"
    task :send_scheduled_bill_email => :environment do 
      BillEmailWorker.new.perform
    end
  end
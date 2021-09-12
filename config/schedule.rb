# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#


# env :PATH, ENV['PATH']
# set :environment, "development"

# set :output, "log/cron.log"

# set :output, {:error => "log/cron_error_log.log", :standard => "log/cron_log.log"}

# every 1.minute do
#     rake 'whenever_call'     
#   end

# every 1.minute do
#     rake 'sample:test'
# end  
every 2.minutes do
    # runner "BillMailer.new_mailer"
    rake "bill_email:send_scheduled_bill_email"
end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

namespace :sample do
    desc 'saying hi to cron'
    task :test => [ :environment ] do
       puts 'hi cron :)'
    end
end
desc "Cron job to be run once daily"
task :cron => :environment do
  Views.rollover!
end

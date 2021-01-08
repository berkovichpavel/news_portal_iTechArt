set :environment, :development
set :output, { error: 'error.log', standard: 'cron.log' }
ENV.each { |k, v| env(k, v) }
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

every 1.day do
  runner "FindAllUsersJob.perform_now"
end

every 1.day do
  runner "RssSubscriptionEveryDayJob.perform_now"
end

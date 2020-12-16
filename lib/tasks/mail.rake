task :mail do
  FindAllUsersJob.perform_now
end

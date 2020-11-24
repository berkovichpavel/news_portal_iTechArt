class SendRssToAdminWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  
  def perform(*args)
    # Do something
  end
end

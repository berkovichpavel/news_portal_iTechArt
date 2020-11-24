class RssParserWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(name, count)
    puts "#{name}, #{count}"
  end
end

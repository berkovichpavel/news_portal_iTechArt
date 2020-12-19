class CountContriesForItemJob < ApplicationJob
  queue_as :default

  def perform(item)
    StatisticsHelper.countries_for_item(item).to_a
  end
end

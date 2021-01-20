require 'rss_parser'
class CreateRssNewsJob < ApplicationJob
  queue_as :default

  def perform(link, category)
    parser = RssParser.new(link, category)
    results = parser.parse
    results.each do |hash_item|
      next if Item.where(reference_link: hash_item[:reference_link]).exists?

      Item.create!(
        title: hash_item[:title],
        short_description: hash_item[:short_description],
        full_text: hash_item[:full_text],
        category: category,
        mask: 'visible',
        reference_link: hash_item[:reference_link],
        rss: true,
        status: 'active',
        main_img: hash_item[:main_img]
      )
    end
  end
end

require 'rss'
require 'open-uri'


class RssParser
  include ActionView::Helpers::UrlHelper

  def initialize(url, category)
    @url = url
    @category = category
  end
  
  def parse
    rss_results = []
    rss = RSS::Parser.parse(open("#{@url}").read, false)
    rss.items.each do |result|
      result = {
        title: result.title,
        short_description: "Details on the link: #{link_to result.link, result.link}",
        full_text: result.description,
        reference_link: result.link,
        main_img: result.enclosure.url
      }
      rss_results.push(result)
    end
    rss_results
  end
end

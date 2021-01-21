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
    rss = RSS::Parser.parse(open(@url.to_s).read, false)
    rss.items.each do |result|
      href = result.enclosure.url
      href[(href.length - 3)...] = 'jpg' if href[(href.length - 3)...] == 'mp4'
      result = {
        title: result.title,
        short_description: "Details on the link: #{link_to result.link, result.link}",
        full_text: result.description,
        reference_link: result.link,
        main_img: href
      }
      rss_results.push(result)
    end
    rss_results
  end
end

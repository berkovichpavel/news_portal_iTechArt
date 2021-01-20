xml.instruct! :xml, version: '1.0'
xml.rss version: '2.0' do
  xml.channel do
    xml.title 'Berdacha News Portal'
    xml.description 'News site'
    xml.language 'en'
    xml.all_items do
      @items.where(status: 'active').each do |item|
        xml.item do
          xml.title item.title
          xml.description item.short_description if item.short_description
          xml.full_text item.full_text if item.full_text
          xml.categories item.category
          xml.image item.main_img if item.main_img
          xml.pubDate item.published_at.to_s(:rfc822) if item.published_at
          xml.reference_link item.reference_link if item.reference_link
        end
      end
    end
  end
end

module ItemsHelper
  include ActsAsTaggableOn::TagsHelper
  DEFAULT_IMAGE = 'https://www.ticketpro.by/storage/img/no-image.png'.freeze

  def find_main_image(item)
    if item.main_img_href.attached?
      url_for(item.main_img_href)
    elsif item.main_img.empty?
      DEFAULT_IMAGE
    else
      item.main_img
    end
  end
end

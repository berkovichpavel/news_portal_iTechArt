module ItemsHelper
  include ActsAsTaggableOn::TagsHelper
  DEFAULT_IMAGE = 'https://www.ticketpro.by/storage/img/no-image.png'.freeze

  def find_main_image(item)
    if item.main_img_href.attached?
      url_for(item.main_img_href)
    elsif item.main_img.blank?
      DEFAULT_IMAGE
    else
      item.main_img
    end
  end

  def item_form_header(item)
    item.new_record? ? t('items.create_new_item') : t('items.edit_item')
  end

  def choose_html_class
    current_user.redactor? ? 'wide-white-form' : 'big-white-form'
  end
end

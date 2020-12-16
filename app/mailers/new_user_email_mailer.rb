class NewUserEmailMailer < ApplicationMailer
  def notify_user(user)
    @user = user
    mail(to: user.email, subject: 'Welcome to Berdacha news portal!')
  end

  def send_items_to_user(email, items)
    @items = items
    @email = email
    @items.each_with_index do |item, index|
      attachments.inline["img_#{index + 1}"] = item.main_img_href.blob.download if item.main_img_href.attached?
    end
    mail(to: email, subject: 'Newsletter from Berdacha news portal!')
  end

  def send_items_statistic_to_admin(email, items)
    @items = items
    @email = email
    mail(to: email, subject: 'Statistic from Berdacha news portal!')
  end
end

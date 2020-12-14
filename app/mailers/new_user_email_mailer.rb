class NewUserEmailMailer < ApplicationMailer
  def notify_user(user)
    @user = user
    mail(to: user.email, subject: 'Welcome to Berdacha news portal!')
  end

  def send_items_to_user(email, items)
    @items = items
    @email = email
    attachments.inline['1'] = File.read('https://media.sproutsocial.com/uploads/2017/02/10x-featured-social-media-image-size.png')
    mail(to: email, subject: 'Newsletter from Berdacha news portal!')
  end
end

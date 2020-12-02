class NewUserEmailMailer < ApplicationMailer
  def notify_user(user)
    @user = user
    mail(to: user.email, subject: 'Welcome to Berdacha news portal!')
  end

  def send_items_to_user(email, items)
    @items = items
    @email = email
    mail(to: email, subject: 'Newsletter from Berdacha news portal!')
  end
end

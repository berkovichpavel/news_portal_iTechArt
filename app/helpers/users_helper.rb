module UsersHelper
  DEFAULT_AVATAR = 'https://bootdey.com/img/Content/avatar/avatar7.png'.freeze

  def check_avatar(user)
    user.photo.attached? ? user.photo : DEFAULT_AVATAR
  end
end

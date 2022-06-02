module ApplicationHelper
  def user_avatar(user)
    if user.photo.nil?
      image_tag user.photo, width: '100'
    else
      image_tag 'user_photo.png', width: '100'
    end
  end
end

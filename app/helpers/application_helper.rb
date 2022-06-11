module ApplicationHelper
  def user_avatar(user)
    if user.photo.nil?
      image_tag 'user_photo.png', width: '100'
    else
      image_tag(user.photo, alt: user.name, width: '100')
    end
  end

  def user_bio(user)
    if user.bio.nil?
      user.bio = 'No bio provided'
    else
      user.bio
    end
  end
end

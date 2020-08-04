module UsersHelper

  def user_avatar(user)
    if user.avatar.attached?
      return `<%= image_tag user.thumbnail, class: "img-fluid rounded-circle" %>`.html_safe
    else
      return `<%= image_tag "default_avatar.jpg", class: 'img-fluid rounded-circle' %>`.html_safe
    end
  end
end

module ApplicationHelper
  def join_or_record_win_button challenge
    if challenge.users.include? current_user
      return `<%= link_to 'Record a Win', #{challenge}, class: 'btn btn-block btn-primary' %>`.html_safe
    else
      return `<%= link_to 'Join Challenge', #{challenge}, class: 'btn btn-block btn-primary' %>`.html_safe
    end
  end
end

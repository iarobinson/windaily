module ApplicationHelper
  def join_or_record_win_button challenge
    if challenge.users.include? current_user
      return `<%= link_to 'Record a Win', #{challenge}, class: 'btn btn-block btn-primary' %>`.html_safe
    else
      return `<%= link_to 'Join Challenge', #{challenge}, class: 'btn btn-block btn-primary' %>`.html_safe
    end
  end

  def standard_column_setting
    "col-sx-6 offset-sx-3 col-sm-8 offset-sm-2 col-md-6 offset-md-3"
  end
end

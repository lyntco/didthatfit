module ApplicationHelper
  def smartnav
    links = ''
    links += "<li>" + link_to('Home', root_path) + "</li>"
    if @current_user.present?
      links += "<li>" + link_to("#{@current_user.username}", user_path(@current_user.username)) + "</li>"
      links += "<li>" + link_to('Add an item', new_item_path) + "</li>"
    end
    if @current_user.present? && @current_user.is_admin? # @current_user.try(:is_admin)
      links += "<li>" + link_to('View users', users_path) + "</li>"
      links += "<li>" + link_to('View items', items_path) + "</li>"
      links += "<li>" + link_to('View brands', brands_path) + "</li>"
    end
    if @current_user.present?
      links += "<li>" + link_to('Settings', edit_user_path(@current_user.username)) + "</li>"
      # links += "<li>" + link_to('What should I wear today?', new_outfit_path) + "</li>"
      links += "<li> #{ link_to("Logout #{ @current_user.username }", login_path, :method => :delete, :data => { :confirm => "Are you sure you want to logout?" })  }</li>"
    else
      links += "<li> #{ link_to('Sign up', new_user_path) } </li>
      <li> #{ link_to('Sign in', login_path ) } </li>"
    end
    # links += "<li>" + search_field_tag("search") + "</li>"

    links
  end
end

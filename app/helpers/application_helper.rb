module ApplicationHelper
  def smartnav
    links = ''
    if @current_user.present? && @current_user.is_admin? # @current_user.try(:is_admin)
      links += "<li>" + link_to('View users', users_path) + "</li>"
      links += "<li>" + link_to('View items', items_path) + "</li>"
      links += "<li>" + link_to('View brands', brands_path) + "</li>"
      links += "<li>" + link_to('View categories', categories_path) + "</li>"
    end
    if @current_user.present?
      links += "<li> #{ link_to("Logout #{ @current_user.username }", login_path, :method => :delete, :data => { :confirm => "Are you sure you want to logout?" })  }</li>"
    else
      links += "<li> #{ link_to('Sign up', '/users/new') } </li>
      <li> #{ link_to('Sign in', login_path ) } </li>"
    end

    links
  end
end

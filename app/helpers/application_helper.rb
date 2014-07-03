module ApplicationHelper
  def smartnav
    links = ''
    # links += "<li>" + link_to('DidThatFit.me', root_path) + "</li>"
    links += "<li>" + link_to('What Brands fit?', brands_path) + "</li>"
    if @current_user.present?
      links += "<li>" + link_to('Recent Items', items_path) + "</li>"
      # links += "<li>" + link_to("#{@current_user.username}", user_path(@current_user.username)) + "</li>"
      links += "<li>" + link_to('Add an item', new_item_path) + "</li>"
    end
    if @current_user.present? && @current_user.is_admin? # @current_user.try(:is_admin)
      links += "<li>" + link_to('View all users', users_path) + "</li>"
      links += "<li>" + link_to('View all items', items_path) + "</li>"
    end

    links
  end
end

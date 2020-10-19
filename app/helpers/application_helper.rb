module ApplicationHelper
  def display_propper_flash
    if flash[:alert]
      content_tag(:div, flash[:alert], class: 'alert alert-danger h-100', align: 'center')
    elsif flash[:notice]
      content_tag(:div, flash[:notice], class: ' alert alert-primary h-100', align: 'center')
    elsif flash[:danger]
      content_tag(:div, flash[:danger], class: 'flash danger h-100', align: 'center')
    end
  end

  def display_goto_menu
    content_tag(:ul, class: 'goto m-3') do
      content_tag(:li, class: '') do
        link_to 'TALKEYS', user_path(current_user), class: 'link'
      end +
        content_tag(:li, class: '') do
          link_to 'FOLLOWERS', '/talkey/1', class: 'link'
        end +
        content_tag(:li, class: '') do
          link_to 'FOLLOWING', '/talkey/2', class: 'link'
        end +
        content_tag(:li, class: '') do
          link_to 'LOGOUT', logout_path, class: 'link'
        end
    end
  end
end

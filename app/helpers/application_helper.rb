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
end

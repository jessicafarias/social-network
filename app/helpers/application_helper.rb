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

  def menu_bluer
    div(
      div(
        image(user_path(current_user), 'img', current_user.avatar) +
        paragraph(current_user.fullname.upcase, 'head'),
        'd-flex justify-content-between align-items-center w-100'
      ) +
      div(
        div(
          paragraph(current_user.followings.count.to_s, '') +
          paragraph('Following', ''),
          'd-flex flex-column align-items-center'
        ) +
        div(
          paragraph(User.fans(current_user).count.to_s, '') +
          paragraph('Followers', ''),
          'd-flex flex-column align-items-center'
        ),
        'row d-flex justify-content-around align-items-center mt-4 w-100'
      ),
      'row bgc-bluer'
    )
  end

  def nav_white
    div(
      link('HOME', opinions_path, 'fa fa-sm fa-home fill-gray mr-2', 'btn-left w-100') +
      link('FOLLOWERS', '/follow/2', 'fa fa-sm fa-at fill-gray mr-2', 'btn-left w-100') +
      link('FOLLOWING', '/follow/1', 'fa fa-sm fa-hashtag fill-gray mr-2', 'btn-left w-100') +
      link('PROFILE', user_path(current_user), 'fa fa-sm fa-user fill-gray mr-2', 'btn-left w-100'),
      'row right'
    )
  end

  def link(text, link_path, class_icon, class_link)
    link_to link_path, class: class_link do
      content_tag(:i, class: class_icon) do
      end + paragraph(text, '')
    end
  end

  def application_display
    menu_bluer + nav_white if current_user?
  end

  def display_icons_nav
    return unless current_user?

    div(
      link('', new_opinion_path, 'fa fa-sm fa-pencil fill-blue', 'level-item mr-5') +
      link('', users_path, 'fa fa-sm fa-search fill-blue', 'level-item mr-5') +
      link('', logout_path, 'fa fa-sm fa-sign-out fill-blue', 'level-item mr-2'),
      'd-flex d-row'
    )
  end
end

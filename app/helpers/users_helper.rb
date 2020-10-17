module UsersHelper
  def paragraph(text, style)
    content_tag(:p, class: style.to_s) do
      text
    end
  end

  def div(content, style)
    content_tag(:div, class: style.to_s) do
      content
    end
  end

  def image(link_path, class_img)
    link_to image_tag('talky.png', alt: 'talkeyuser', class: class_img), link_path
  end

  def go_to(link_path, class_icon)
    link_to link_path do
      content_tag(:i, class: class_icon) do
      end
    end
  end

  def display_userlist
    list_item = content_tag(:div, class: '') do
    end
    if @users.any?
      @users.each do |user|
        list_item +=
          div(
            image(user_path(user), 'image m-4') +
            div(
              paragraph(user.fullname, 'user') +
              (paragraph(user.opinions.last.body, 'opinion') if user.opinions.any?),
              'd-flex flex-column justify-content-center'
            ), 'd-flex flex-row'
          )
      end
    end
    div(paragraph(@tag, 'head') + list_item, 'talk')
  end

  def follow(user)
    div(
      div(image(user_path(user), 'w-100'), 'col-3 d-flex align-items-center') +
      div(paragraph(user.fullname, '') + paragraph(user.username, ''),
          'col-6 d-flex justify-content-center flex-column') +
      go_to("/startfollow/#{user.id}", 'fa fa-2x fa-plus-circle fill-white m-3'),
      'row mt-3'
    )
  end

  def whotofollow
    list_item = content_tag(:div, class: '') do
    end
    if @whotofollow.any?
      @whotofollow.each do |user|
        list_item += follow(user)
      end
    end
    list_item
  end
end

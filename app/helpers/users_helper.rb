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

  def image(link_path, class_img, image)
    link_to image_tag(image, alt: 'profle', class: class_img), link_path
  end

  def cloud(link_path, class_img, user_av)
    link_to cl_image_tag(user_av.key, secure: true, class: class_img), link_path
  end

  # def cloud_profile(link_path, class_img, user_av)
  #  link_to cl_image_tag(user_av.key, secure: true, width: 500, height:500), link_path
  # end

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
            cloud(user_path(user), 'image m-4', user.avatar) +
            div(paragraph(user.fullname, 'user') +
              (paragraph(user.opinions.last.body, 'opinion') if user.opinions.any?),
                'd-flex flex-column justify-content-center'), 'd-flex flex-row'
          )
      end
    end
    div(paragraph(@tag, 'head') + list_item, 'talk')
  end

  def follow(user)
    div(
      div(cloud(user_path(user), 'image', user.avatar),
          'col-3 d-flex align-items-center') +
      div(paragraph(user.fullname, '') + paragraph(user.username, ''),
          'col-6 d-flex justify-content-center flex-column') +
      (unless current_user.follow?(user)
         go_to("/startfollow/#{user.id}",
               'fa fa-2x fa-plus-circle fill-white col-3 mt-2')
       end),
      'row m-auto d-flex flex-nowrap'
    )
  end

  def whotofollow
    list_item = content_tag(:div, class: 'm-auto') do
    end
    if @whotofollow.any?
      @whotofollow.each do |user|
        list_item += follow(user)
      end
    end
    list_item
  end

  def display_user_show
    div(
      if current_user.follow?(@user) && current_user != @user
        link_to following_path(current_user.stop_to_follow(@user)),
                method: :delete, data: { confirm: 'Are you sure you stop follow' } do
          content_tag(:i, class: 'fa fa-2x fa-minus-circle fill-white p-3') do
          end
        end
      elsif current_user != @user
        go_to("/startfollow/#{@user.id}", 'fa fa-2x fa-plus-circle fill-white p-3')
      else
        content_tag(:i, class: 'fa fa-2x fa-check-circle fill-white p-3') do
        end
      end +
      cloud('', 'profile', @user.avatar) +
      go_to(root_path, 'fa fa-2x fa-gg-circle fill-white p-3'),
      'd-flex align-items-center justify-content-center m-auto'
    )
  end

  private

  def set_lists
    case params[:list]
    when '1'
      @users = current_user.followings.with_attached_avatar.includes(%i[opinions])
      @tag = 'FOLLOWING'
    when '2'
      @users = User.fans(current_user).includes([:opinions])
      @tag = 'FOLLOWERS'
    else
      @users = User.all.where('id!=?', current_user.id).with_attached_avatar.includes(%i[opinions])
      @tag = 'ALL USERS'
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :fullname, :avatar, :cover_image)
  end
end

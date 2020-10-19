module OpinionsHelper
  def display_opinions
    list_item = content_tag(:div, class: '') do
    end
    if @opinions.any?
      @opinions.order_desc.each do |opinion|
        list_item +=
          div(
            image(user_path(opinion.user), 'image m-4') +
            div(
              paragraph(opinion.user.fullname, 'user') +
              paragraph(opinion.body, 'opinion'),
              'd-flex flex-column justify-content-center'
            ), 'd-flex flex-row'
          )
      end
    end
    div(paragraph(@tag, 'head') + list_item, 'talk')
  end

  def set_lists
    case params[:list]
    when '1'
      @opinions = current_user.opinions
      @ids = User.fans(current_user).select(:id)
      @opinions = Opinion.all.order_desc.where(user_id: @ids)
      @tag = 'OPINIONS FROM FOLLOWERS'

    when '2'
      @ids = current_user.followings.select(:id)
      @opinions = Opinion.all.order_desc.where(user_id: @ids)
      @tag = 'OPINIONS FROM PEOPLE WHO YOU ARE FOLLOWING'

    else
      @opinions = Opinion.all
      @tag = 'ALL OPINIONS FROM ALL USERS'
    end
  end

  private

  def set_opinion
    @opinion = Opinion.find(params[:id])
  end

  def opinion_params
    params.require(:opinion).permit(:body)
  end
end

class OpinionsController < ApplicationController
  include OpinionsHelper
  before_action :authenticate_user!
  before_action :set_opinion, only: %i[show edit update destroy]

  def index
    set_lists
    @opinion = Opinion.new
    @whotofollow = User.with_attached_avatar.who_to_follow(current_user)
  end

  def show
    set_lists
  end

  def new
    @opinion = Opinion.new
    @opinions = current_user.opinions.order_desc
  end

  def edit; end

  def create
    @opinion = Opinion.new(opinion_params)
    @opinion.user_id = User.find_by(username: current_user.username.to_s).id
    respond_to do |format|
      if @opinion.save
        format.html { redirect_to new_opinion_path, notice: 'Opinion was successfully created.' }
        format.json { render :show, status: :created, location: @opinion }
      else
        format.html { render :new }
        format.json { render json: @opinion.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @opinion.update(opinion_params)
        format.html { redirect_to new_opinion_path, notice: 'Opinion was successfully updated.' }
        format.json { render :show, status: :ok, location: @opinion }
      else
        format.html { render :edit }
        format.json { render json: @opinion.errors, status: :unprocessable_entity }
      end
    end
  end
end

class UsersController < ApplicationController
  include UsersHelper
  before_action :authenticate_user!, except: %i[new create]
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @opinion = Opinion.new
    @whotofollow = User.with_attached_avatar.who_to_follow(current_user)
    set_lists
  end

  def show
    @opinion = Opinion.new
    @whotofollow = User.with_attached_avatar.fans(@user)
    @opinions = @user.opinions.order_desc.includes([:user])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        if current_user?
          format.html { redirect_to root_path, notice: 'User was successfully created' }
        else
          format.html { redirect_to login_path, notice: 'User was successfully created please LogIn.' }
          format.json { render :show, status: :created, location: @user }
        end
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, alert: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
end

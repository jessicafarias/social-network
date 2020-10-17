class UsersController < ApplicationController
  include UserSessionsHelper
  before_action :authenticate_user!, except: %i[new create]
  before_action :set_user, only: %i[show edit update destroy]

  # GET /users
  # GET /users.json
  def index
    @opinion = Opinion.new
    @whotofollow = User.who_to_follow(current_user)
    case params[:list]
    when '1'
      @users = current_user.followings
      @tag = 'FOLLOWING'
    when '2'
      @users = User.fans(current_user)
      @tag = 'FOLLOWERS'
    else
      @users = User.all.where('id!=?', current_user.id)
      @tag = 'ALL USERS'
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @opinion = Opinion.new
    @users = User.fans(@user)
    @opinions = @user.opinions.order_desc
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit; end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to login_path, notice: 'User was successfully created please LogIn.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
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

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, alert: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:username, :fullname)
  end
end

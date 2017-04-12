class UsersController < ApplicationController
  before_action :authorize, only: [:show, :edit, :update]
  before_action :own, only: [:show, :edit, :update]

  # attr_reader :user

  def index
    @users = User.all
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_url, notice: 'User was successfully created.' }
        format.json { render :index, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :'412' }
      end
    end
  end

  def show
    @user = current_user
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def own
    unless current_user.id == User.find(params[:id]).id
      respond_to do |format|
        format.html {
          redirect_to login_path
        }
        format.js {
          render 'home/forbidden', formats: [:js], status: :forbidden
        }
      end
    end
  end

  def authorize
    login_then_redirect_to request.path unless current_user
  end

  def login_then_redirect_to url
    session[:login_callback] = url
    redirect_to login_path
  end
end
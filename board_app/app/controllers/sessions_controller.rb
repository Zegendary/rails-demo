class SessionsController < ApplicationController
  def new

  end

  def create
    email = params[:session][:email]
    password = params[:session][:password]

    user = User.find_by_email(email)
    if user && user.authenticate(password)
      log_in(user)
      redirect_to user_path(user)
    else
      render new_user_path
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def logged_in?
    !current_user.nil?
  end

  def forget(user)
    user.forget #将user.remeber_digest重置为nil
    #删除cookies中的登录信息
    cookies.delete(:user_id)
    cookies.delete(:remeber_token)
  end

  def log_out(user)
    session.delete(:user_id)
  end

  def current_user
    #先判断session中是否为nil
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
      #再判断cookies中是否保存了登录信息
    else (user_id = cookies.signed[:user_id])
    user = User.find_by(id: user_id)
    #如果cookies中保存了，再用authenticated?这个方法判断cookies[:remeber_token]或者数据库中的remeber_digest是否一致。
    if user && user.authenticated?(cookies[:remeber_token])
      log_in(user)
      @current_user = user
    end
    end
  end
end
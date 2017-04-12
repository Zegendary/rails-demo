class SessionsController < ApplicationController


  def new

  end

  def create
    email = params[:session][:email]
    password = params[:session][:password]

    user = User.find_by_email(email)
    #authenticate是has_secure_password引入的一个方法，用来判断user的密码与页面中传过来的密码是否一致
    if user && user.authenticate(password)
      log_in(user) #SessionsHelper中的方法
      redirect_to user_path(user)
    else
      flash.now[:danger] = "Invalid login or password."
      render 'new',status: '400'
    end
  end

  def destroy
    log_out if logged_in? #SessionsHelper中的方法
    redirect_to root_path
  end

end
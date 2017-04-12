module SessionsHelper
  #一旦账号密码正确，则成功登录，同时在session中记录session[:user_id]
  def log_in(user)
    session[:user_id] = user.id
  end

  #获取当前登录用户，如未登录，则为nil.@current_user这个实例变量是为了避免每次调用current_user方法都去查询一遍数据库的情况。
  def current_user
    #先判断session中是否为nil
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    end
  end
  #用来判断用户是否登录的方法
  def logged_in?
    !current_user.nil?
  end

  #退出，同时删除session中的信息
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end

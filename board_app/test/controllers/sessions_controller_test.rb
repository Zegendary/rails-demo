require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "login success" do

  end

  test '登录页没挂 get new' do
    get login_url
    assert_response :success
  end

  test '登录成功 post create' do
    post login_url, params: {
        session: {
            email: 'zxw1992513@qq.com',
            password: 'zxw1992513'
        }
    }
    assert_response :redirect
    follow_redirect!
    assert_response :ok
    assert_not_nil controller.session[:user_id]
  end

  test '登录失败 post create' do
    post login_url, params: {
        session: {
            email: 'xxxxx@qq.com',
            password: 'xxxxxx'
        }
    }
    assert_response 400
  end

  test '登出成功 delete destroy' do
    post login_url, params: {
        session: {
            email: 'zxw1992513@qq.com',
            password: 'zxw1992513'
        }
    }
    delete logout_url
    assert_response :redirect
    assert_nil controller.session[:user_id]
  end
end

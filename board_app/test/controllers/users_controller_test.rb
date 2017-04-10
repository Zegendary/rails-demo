require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: { user: { name: 'zhangxw',
                                        email: 'zxw1992513@qq.com',
                                        password_digest: '111111',
                                        password_confirmation: '111111'} }
    end
    assert_redirected_to users_url
  end
end
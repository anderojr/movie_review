require 'test_helper'

class Users::SessionsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @user = users(:regular_user)
  end

  test 'should redirect to password change page when user login and new_password_required? is true' do
    post user_session_path, params: { user: { username: @user.username, password: 'password' } }
    assert_redirected_to edit_user_registration_path
    assert_equal 'You need to change your password', flash[:alert]
  end
end

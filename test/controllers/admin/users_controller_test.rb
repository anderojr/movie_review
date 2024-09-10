require "test_helper"

class Admin::UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @admin_user = users(:admin_user) # Load the admin user fixture
    @regular_user = users(:regular_user) # Load the regular user fixture
  end

  test "should not allow non-admin users to access any action" do
    sign_in @regular_user

    # test admin/users#create
    post admin_users_path
    assert_redirected_to root_path
    assert_equal 'Access denied', flash[:alert]

    # test admin/users#new
    get new_admin_user_path
    assert_redirected_to root_path
    assert_equal 'Access denied', flash[:alert]

    # test admin/users#edit
    get edit_admin_user_path(@regular_user)
    assert_redirected_to root_path
    assert_equal 'Access denied', flash[:alert]

    # test admin/users#update
    patch admin_user_path(@regular_user), params: { user: { first_name: "Updated" } }
    assert_redirected_to root_path
    assert_equal 'Access denied', flash[:alert]
  end

  test "user must change password if password was updated by admin" do
    sign_in @admin_user
    patch admin_user_path(@regular_user), params: { user: { password: "new_password", password_confirmation: "new_password" } }
    @regular_user.reload
    assert @regular_user.new_password_required?
  end
end

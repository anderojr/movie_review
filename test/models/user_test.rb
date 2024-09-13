require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'first_name and last_name only contain letters and spaces' do
    user = User.new(username: 'testuser', first_name: 'John', last_name: 'Doe')
    assert user.valid?

    user.first_name = 'John123'
    assert_not user.valid?
    assert_equal ['can only contain letters and spaces'], user.errors.messages[:first_name]

    user.first_name = 'John Doe'
    assert user.valid?

    user.last_name = 'Doe123'
    assert_not user.valid?
    assert_equal ['can only contain letters and spaces'], user.errors.messages[:last_name]

    user.last_name = 'Doe Doe'
    assert user.valid?
  end

  test "username only allows alphanumeric characters, '.', '_', and '-'" do
    user = User.new(username: 'testuser', first_name: 'John', last_name: 'Doe')
    assert user.valid?

    user.username = 'test@user'
    assert_not user.valid?
    assert_equal ["can only contain letters, numbers, '.', '_', and '-'"], user.errors.messages[:username]

    user.username = 'test_user'
    assert user.valid?

    user.username = 'test-user'
    assert user.valid?

    user.username = 'test user'
    assert_not user.valid?
    assert_equal ["can only contain letters, numbers, '.', '_', and '-'"], user.errors.messages[:username]
  end

  test 'strip_namespaces method removes leading and trailing spaces from first_name and last_name' do
    user = User.new(username: 'testuser', first_name: ' John ', last_name: ' Doe ')
    user.save
    assert_equal 'John', user.first_name
    assert_equal 'Doe', user.last_name
  end
end

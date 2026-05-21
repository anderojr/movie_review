User.find_or_create_by!(username: 'admin') do |user|
  user.first_name = 'Admin'
  user.last_name = 'User'
  user.password = 'changeme'
  user.admin = true
  user.valid_password = false
end

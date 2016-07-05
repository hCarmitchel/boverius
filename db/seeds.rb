# puts 'Adding admin user'
# user = User.find_or_create_by!(email: 'veryboveriwedding@gmail.com', first_name: 'Very', last_name: 'Boveri', admin: true, encrypted_password: '$2a$10$TxR5hSCXgMPiHvQ5sYKFdOAZvb/g30uTCMW4ixmN/2IIEG.TQxWwS')
# user.toggle!(:admin)
# puts 'New user created: ' << user.name

# puts 'Adding registries'
registries = {
  'Amazon' => 'https://www.amazon.com/gp/registry/wedding/U975U00FSH3N'
}

registries.each_pair do |name, url|
  Registry.find_or_create_by(name: name, url: url)
end

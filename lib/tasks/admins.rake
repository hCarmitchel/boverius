namespace :admins do
  desc 'Create admin privilege'
  task :create, [:id] => :environment do |t, args|
    begin
      user = User.find(args[:id])
      user.admin = true
      user.save!
      puts "#{user.name} (#{user.id}): #{user.admin}"
    rescue => e
      puts e
    end
  end

  desc 'Remove admin privilege'
  task :remove, [:id] => :environment do |t, args|
    begin
      user = User.find(args[:id])
      user.admin = false
      user.save!
      puts "#{user.name} (#{user.id}): #{user.admin}"
    rescue => e
      puts e
    end
  end

  desc 'List admins'
  task :list, [] => :environment do |t, args|
    puts "User name (id): admin"
    User.all.each do |user|
      puts "#{user.name} (#{user.id}): #{user.admin}"
    end
  end
end

namespace :invite_codes do
  desc 'Create invite code'
  task :create, [:value, :guests] => :environment do |_, args|
    value = args[:value]
    guests = args[:guests]
    code = InviteCode.find_or_create_by(value: value, guests: guests)
    code.save!
  end

  desc 'Delete invite code'
  task :delete, [:id] => :environment do |_, args|
    if User.where(invite_code_id: args[:id]).any?
      InviteCode.find(args[:id]).destroy
    else
      puts "Invote Code #{InviteCode.find(args[:id]).value} cannot be deleted as it is in use"
    end
  end

  desc 'List invite codes'
  task :list, [] => :environment do |_|
    puts 'Invite value (id): # guests'
    puts '---------------------'
    InviteCode.all.each do |code|
      puts "#{code.value} (#{code.id}): #{code.guests}"
    end
  end
end

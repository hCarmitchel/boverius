namespace :invite_codes do
  desc 'Create invite code'
  task :create, [:value, :guests] => :environment do |t, args|
    code = InviteCode.find_or_create_by(value: args[:value], guests: args[:guests])
    code.save!
  end

  desc 'Delete invite code'
  task :delete, [:value] => :environment do |t, args|
    InviteCode.where(value: args[:value]).destroy_all
  end

  desc 'List invite codes'
  task :list, [] => :environment do |t, args|
    InviteCode.all.each do |code|
      puts "#{code.value}: #{code.guests}"
    end
  end
end

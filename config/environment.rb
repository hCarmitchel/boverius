# Load the Rails application.
require File.expand_path('../application', __FILE__)

if !Rails.env.development
  Rails.logger = Le.new('LOGENTRIES_TOKEN')
else
  Rails.logger = Le.new('LOGENTRIES_TOKEN', local: true)
end

# Initialize the Rails application.
Rails.application.initialize!

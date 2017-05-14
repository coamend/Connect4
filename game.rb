require 'gli'

include GLI::App

pre do |global_options,command,options,args|
    # Load game from db here
end

command :new do |c|
    c.action do |options,args|
    end
end

command :show do |c|
    c.action do
    end
end

command :turn do |c|
    c.action do |options,args|
    end
end

exit run(ARGV)
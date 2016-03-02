require 'json'

@rep = {}

env = 'env'
dom = 'domain.com'
dir = './capistrano/config/deploy/'

base = {}
base = Dir.entries(dir).reject{|entry| entry =~ /^\.{1,2}$/}

base.each do |d|
	domain = "#{d}.#{dom}"
	@rep[d] = { "url" =>  domain }
end

@result = { "environment" => env , "services" => @rep }

File.open('#{env}.json', "w") do |f|
	f.write JSON.pretty_generate(@result)
end

puts  JSON.pretty_generate(@result)

require 'json'
require "net/https"
require "uri"

user = 'git_username'
token = 'access_token'
org = 'org_name'
indexers = 4

@rep = {}

uri = URI.parse("https://api.github.com/orgs/#{org}/repos?per_page=400")
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Get.new(uri.request_uri)
request.basic_auth("#{user}", "#{token}")
response = http.request(request)

@all = JSON.parse(response.body)

@all.each do |j|
	n = j["name"]
	u = j["ssh_url"]
	@rep[n] = { "url"  => u }
end

@file = { "max-concurrent-indexers" => indexers , "dbpath" => "data" , "repos" => @rep } 

File.open('config.json', "w") do |f|
	f.write JSON.pretty_generate(@file)
end

#puts JSON.pretty_generate(@file)

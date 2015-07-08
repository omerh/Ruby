require 'rubygems'
require 'date'
require 'httparty'
require 'zip/zip'
require 'fileutils'
require 'sambal'

username = 'ip2location user name'
password = 'ip2location password'
#DB Type to download
dbpack = 'DB5BIN'
datestemp = Date.today.to_s
target = '/mnt/software/ip2location/'
filename = 'db5.zip'
downloadurl = 'http://www.ip2location.com/download?login=' + username + '&password=' + password + '&productcode=' + dbpack
dbname = 'IP-COUNTRY-REGION-CITY-LATITUDE-LONGITUDE.BIN'
smbuser = 'domain user for samba mapping'
smbpassword = 'domains user password'
domain = 'domain name'
targetservers = [ 'serverip', 'serverip' ]
targetsmb = 'Resources'

#Create download directory
download_dir = target + datestemp
Dir.mkdir(download_dir)

## Downloading file from ip2location.com webservice
the_file = download_dir + '/' + filename
File.open(the_file, "wb") do |f|
	f.write HTTParty.get(downloadurl).parsed_response
end

## Unziping current download ip2location file
Zip::ZipFile.open(the_file) do |zipfile|
	zipfile.each do |file|
	file.extract(download_dir + '/' + file.name)
	end
end

## Move file to upper level
dbpath = download_dir + '/' + dbname
FileUtils.cp(dbpath, target)

#Send to servers
targetservers.each do |server|
	client = Sambal::Client.new(domain: domain, host: server , share: targetsmb, user: smbuser, password: smbpassword)
	puts "Connection to server #{server}"
	client.put(dbpath,dbname)
	client.close
end

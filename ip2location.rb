require 'rubygems'
require 'date'
require 'httparty'
require 'zip/zip'
require 'fileutils'
require 'sambal'

username = 'ip2location_user'
password = 'ip2location_passwrod'
dbpack = 'db_name'
datestemp = Date.today.to_s
target = 'path_to_save'
filename = 'file_name_to_save'
downloadurl = 'http://www.ip2location.com/download?login=' + username + '&password=' + password + '&productcode=' + dbpack
dbname = 'IP-COUNTRY-REGION-CITY-LATITUDE-LONGITUDE.BIN'
smbuser = 'domainuser'
smbpassword = 'domainpassword'
domain = 'domainname'
targetservers = [ 'server_ip', 'server_ip']
targetsmb = 'share_name'

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

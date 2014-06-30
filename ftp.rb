require 'rubygems'
require 'net/ftp'

#FTP Details
ftpurl = 'ftp.server.ip'
username = 'ftpusername'
password = 'ftppassword'

#FTP Connect
ftp = Net::FTP::new
ftp.connect(ftpurl,port)
ftp.login(username,password)
ftp.passive = true
ftp.debug_mode = true

target = '/mnt'
locations = [["/path_to_save_files/","search_teem_in_ftp_*"], ["/path_to_save_files/","search_teem_in_ftp_*"]]

locations.each do |location|
	#path location[0]
	#search term location[1]

	search = location[1]
	files = ftp.nlst(search)

	files.each do |file|
        newfile = file.gsub(' ','_').gsub('(','').gsub(')','').gsub(':','-')
        temp = target + newfile
        destination = target + location[0] + newfile
		puts destination
		ftp.getbinaryfile(file,destination)
        ftp.rename(file,'DOWNLOADED_'+file)
	end
	puts "Finished with #{location[1]}"
end

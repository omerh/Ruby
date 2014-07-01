require 'sambal'

targetservers = [ 'serverip', 'serverip']
targetsmb = 'sahreName'
smbuser = 'domainuser'
smbpassword = 'domainpassword'
domain = 'domainname'


targetservers.each do |server|
	puts "Connection to server #{server}" 
	client = Sambal::Client.new(domain: domain, host: server , share: targetsmb, user: smbuser, password: smbpassword)
	client.put('local_file', 'remote_file_name')
	client.close
end

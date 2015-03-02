require 'net/smtp'



def send_email(text)	
msg = <<EOM
Subject: Exception
#{text}    
EOM
	Net::SMTP.start('localhost') do |smtp|
		smtp.send_message msg, 'fromemail', 'toemail'
	end
end

begin
	file = open('/testststs.dfdf')
rescue Exception => e
	send_email(e)
end

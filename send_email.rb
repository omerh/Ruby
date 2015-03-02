require 'socket'
require 'net/smtp'

#smtp mail info
from_address = Socket.gethostname + '@yourdomain.com'
to_address = 'to'
smtp_server = 'smtp server'

def send_email(_host, _from, _to, _message)

msg = <<EOM
Subject: Exception occured
#{_message}
EOM

Net::SMTP.start(_host) do |smtp|
	smtp.send_message msg, _from,_to
end
end

send_email(smtp_server, from_address,to_address, 'your body message')

#!/usr/bin/ruby
require 'rubygems'
require 'net/ftp'
require 'fileutils'
require 'net/smtp'
require 'socket'
#FTP Details
$ftpurl = 'ftp_url'
$username = 'ftpuser'
$password = 'ftppass'
$target = '/mnt/path'

#smtp mail info
$from_address = Socket.gethostname + '@domain.com'
$to_address = 'to_email'
$smpthost = 'smtp server'

def send_email(message)
msg = <<EOM
Subject: Exception was found
#{message}
EOM
puts $smpthost
  Net::SMTP.start($smpthost) do |smtp|
    smtp.send_message msg, $from_address, $to_address
  end
end

begin
  #FTP Connect
  ftp = Net::FTP::new
  ftp.connect($ftpurl)
  ftp.login($username,$password)
  ftp.passive = true
  #ftp.debug_mode = true
  f = ftp.nlst()
  if f.count > 0
    f.each do |file|
      savefile = $target + "#{Time.now.strftime "%Y-%m-%d"}" + '_' + "#{file}"
      ftp.getbinaryfile(file,savefile)
      ftp.rename(file,'_' + file)
      send_email('file was downloaded')
    end
  else
    puts "nothing to download"
    send_email('I have nothhing to download')
  end
rescue Exception => e
  puts "arrr.... exception: #{e}"
  send_email(e)
ensure
  ftp.quit
end

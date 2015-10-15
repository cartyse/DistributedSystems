require 'socket'  
message = ARGV[1]
port = ARGV[0]

s = TCPSocket.new( "localhost", port )  
s.write(message)
str = s.recv( 1024 )  
print str 
print "\n"
print "\n"
s.close

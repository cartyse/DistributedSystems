require "socket"  
port = ARGV[0]
dts = TCPServer.new('localhost', port)  

puts "Server now open on port: #{port}"

POOL_SIZE = 2
#jobs = Queue.new

workers = (POOL_SIZE).times.map do
	Thread.new do 
		begin 
			while (client = dts.accept)
				puts Thread.current 
				input = client.recv(1024)
				if input.start_with?("HELO")
					puts "#{input}IP:#{client.peeraddr[2]}\nPort:#{port}\nStudentID:[2]\n"
					client.write("#{input}\nIP:#{client.peeraddr[2]}\nPort:#{port}\nStudentID:[1ed228fe0a47f43eaf4eb8f141cfaa54da1ca82e7deb0256dcb231db3dbebc94\n")
				elsif input == "KILL_SERVICE"
      				puts "KILL server"
      				client.write("SERVER KILLED\n")
      				Thread.list.each do |thread|
  						thread.exit
					end
				else
					client.write("Message Received\n")
				end
			end
		rescue ThreadError
		end
	end
end
workers.map(&:join)
dts.close

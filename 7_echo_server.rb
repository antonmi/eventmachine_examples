require 'eventmachine'

# define hanler
class Server < EM::Connection
	@@client_count = 0
	def initialize(queue)
		@queue = queue
	end

	def post_init
		@@client_count += 1
		puts "Client #{@@client_count} connected"
	end

	def receive_data(data)
		puts "Receved data #{data}"
		@queue.push(data)
	end

	def unbind
		puts "Client disconnected"
		@@client_count -= 1
		if @@client_count == 0 
			puts "Message history"
			while !@queue.empty? 
			   puts @queue.pop
			end  
			EM.stop
		end	
	end

end

EM.run do 
	queue = Queue.new

	EM.start_server "localhost", 9876, Server, queue
    
    EM.add_periodic_timer(2) do
    	puts "Total messages: #{queue.size}"
	end
end
require 'eventmachine'

EM.run do	

	queue = EM::Queue.new

	#queue is waiting for data
	EM.tick_loop do
	  queue.pop { |item| item.call } 
	end

	EM.add_periodic_timer(1) do
	   queue.push proc{ puts "EventMachine"}
	end	


end
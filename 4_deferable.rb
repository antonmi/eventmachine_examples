require 'eventmachine'

class Dfr      #EM::DefaultDeferrable
	include EM::Deferrable
end


EM.run do
	dfr = Dfr.new  #or dfr = EM::DefaultDeferrable
	
	dfr.callback { puts "First callback"}
  
  dfr.callback do |arg| 
   	puts "Callback with #{arg}"
   	dfr.callback do
   	  puts "Callback inside callback"
   	end
  end 
	
	dfr.errback { |err| puts "Errback with #{err}" }
  	
  EM.add_periodic_timer(0.3) do
    puts "Another callback added"
 	  dfr.callback do 
 	 	  puts "Callback spaghetti" 
 	 	  dfr.fail("EventMachine")  #so only one spaghetti
 	  end 	
  end


  EM.add_timer(1) do
   	dfr.succeed("EventMachine") 
   	EM.stop
  end	

#cancell callback ======
	pr = Proc.new { puts "I will be cancelled" }
	dfr.callback &pr
	dfr.cancel_callback pr
#=======================
end
